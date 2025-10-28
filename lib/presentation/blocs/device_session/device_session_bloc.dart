import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../features/device_session/device.dart';
import '../../../features/device_session/device_session_service.dart';
import '../../../shared/interface.dart';
import '../../../shared/result.dart';

part 'device_session_event.dart';

part 'device_session_state.dart';

class DeviceSessionBloc extends Bloc<DeviceSessionEvent, DeviceSessionState> {
  DeviceSessionBloc(this._sessionService) : super(NotConnected()) {
    on<ConnectToDevice>(_onConnectToDevice);
    on<ConnectedSuccessfully>(_onConnectedSuccessfully);
    on<ConnectionAttemptFailed>(_onConnectionAttemptFailed);
  }

  final DeviceSessionService _sessionService;

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
        add(ConnectedSuccessfully(data));
      case Failure(:final error):
        add(ConnectionAttemptFailed(error));
    }
  }

  void _onConnectedSuccessfully(
    ConnectedSuccessfully event,
    Emitter<DeviceSessionState> emit,
  ) {
    emit(Connected(event.device));
  }

  void _onConnectionAttemptFailed(
    ConnectionAttemptFailed event,
    Emitter<DeviceSessionState> emit,
  ) {
    emit(NotConnected(error: event.connectionError));
  }
}
