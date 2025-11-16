import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../../features/device_info/device_data.dart';
import '../../../features/device_info/telemetry_data.dart';
import '../../../features/device_session/device.dart';
import '../../../features/device_session/device_event.dart';
import '../../../features/device_session/device_session_service.dart';
import '../../../remotes/device_api/generated/pyrion/v1/controller_message.pb.dart';
import '../../../shared/interface.dart';
import '../../../shared/origin.dart';
import '../../../shared/result.dart';

part 'device_session_event.dart';

part 'device_session_state.dart';

class DeviceSessionBloc extends Bloc<DeviceSessionEvent, DeviceSessionState> {
  DeviceSessionBloc(this._sessionService) : super(NotConnected()) {
    on<ConnectToDevice>(_onConnectToDevice);
    on<ConnectedSuccessfully>(_onConnectedSuccessfully);
    on<ConnectionAttemptFailed>(_onConnectionAttemptFailed);
    on<DisconnectDevice>(_onConnectionLost);
    on<UpdateTelemetry>(_onUpdateTelemetry);
  }

  final DeviceSessionService _sessionService;
  final Logger _logger = Logger('DeviceSessionBloc');
  StreamSubscription<DeviceEvent>? _deviceSubscription;
  StreamSink<ControllerMessage>? _deviceSink;

  Future<void> _onConnectToDevice(
    ConnectToDevice event,
    Emitter<DeviceSessionState> emit,
  ) async {
    emit(Connecting(deviceName: event.deviceName));
    await Future.delayed(const Duration(milliseconds: 500));
    final connectionResult = await _sessionService.connect(
      event.connectionString,
      event.interface,
      event.deviceName,
    );

    switch (connectionResult) {
      case Success(:final data):
        _deviceSink = data.sink;
        _deviceSubscription = data.stream.listen(
          _onDeviceMessage,
          onDone: _onConnectionClosed,
          onError: _onConnectionError,
        );
        add(ConnectedSuccessfully(data));
      case Failure(:final error):
        add(ConnectionAttemptFailed(error));
    }
  }

  void _onConnectedSuccessfully(
    ConnectedSuccessfully event,
    Emitter<DeviceSessionState> emit,
  ) {
    emit(
      Connected(
        deviceData: event.device.deviceData,
        telemetryData: const TelemetryData.empty(),
      ),
    );
  }

  void _onConnectionAttemptFailed(
    ConnectionAttemptFailed event,
    Emitter<DeviceSessionState> emit,
  ) {
    emit(NotConnected(error: event.connectionError));
  }

  void _onDeviceMessage(DeviceEvent event) {
    if (event is! TelemetryEvent) {
      _logger.fine('Device message received: $event');
    }

    switch (event) {
      case TelemetryEvent():
        final state = this.state;
        if (state is Connected) {
          add(
            UpdateTelemetry(
              TelemetryData(
                driverTemperature: event.driverTemperature,
                cpuTemperature: event.cpuTemperature,
                currentConsumption: event.currentConsumption,
                dutyCycle: event.dutyCycle,
                motorTemperature: event.motorTemperature,
                powerConsumption: event.powerConsumption,
                uptime: event.uptime,
                vBus: event.vBus,
              ),
            ),
          );
        }
      case DeviceIntroductionEvent():
        break;
    }
  }

  void _onConnectionClosed() {
    _logger.warning('Connection to device lost');
    add(const DisconnectDevice(Origin.remote));
  }

  void _onConnectionError(Object error, StackTrace stackTrace) {
    _logger.warning('Got error from device message stream', error, stackTrace);
  }

  void _onConnectionLost(
    DisconnectDevice event,
    Emitter<DeviceSessionState> emit,
  ) {
    _deviceSink?.close();
    _deviceSubscription?.cancel();
    _deviceSink = null;
    _deviceSubscription = null;
    final error = switch (event.eventOrigin) {
      Origin.remote => ConnectionError.connectionLost,
      Origin.local => null,
    };
    emit(NotConnected(error: error));
  }

  void _onUpdateTelemetry(
    UpdateTelemetry event,
    Emitter<DeviceSessionState> emit,
  ) {
    final state = this.state;
    if (state is Connected) {
      emit(state.copyWith(telemetryData: event.telemetryData));
    }
  }

  @override
  Future<void> close() {
    _deviceSubscription?.cancel();
    _deviceSink?.close();
    _deviceSubscription = null;
    _deviceSink = null;
    return super.close();
  }
}
