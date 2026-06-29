import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../../features/device_session/device_session.dart';
import '../../../features/device_session/device_session_factory.dart';
import '../../../shared/interface.dart';
import '../../../shared/result.dart';

part 'device_session_event.dart';

part 'device_session_state.dart';

class DeviceSessionBloc extends Bloc<DeviceSessionEvent, DeviceSessionState> {
  DeviceSessionBloc(this._sessionService) : super(NotConnected()) {
    on<ConnectToDevice>(_onConnectToDevice);
    on<ConnectedSuccessfully>(_onConnectedSuccessfully);
    on<ConnectionAttemptFailed>(_onConnectionAttemptFailed);
    on<ConnectionLost>(_connectionLost);
    on<DisconnectDevice>(_onDisconnectDevice);
  }

  final DeviceSessionFactory _sessionService;
  final Logger _logger = Logger('DeviceSessionBloc');

  Future<void> _onConnectToDevice(
    ConnectToDevice event,
    Emitter<DeviceSessionState> emit,
  ) async {
    emit(Connecting(deviceName: event.deviceName));
    await Future.delayed(const Duration(milliseconds: 500));
    final connectionResult = await _sessionService.open(
      connectionString: event.connectionString,
      interface: event.interface,
      deviceName: event.deviceName,
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
    emit(Connected(event.session));

    event.session.done.then((reason) {
      if (isClosed) {
        return;
      }

      switch (reason) {
        case SessionEndReason.localClose:
          _logger.info('Goodbye!');
          break;
        case SessionEndReason.remoteClosed:
        case SessionEndReason.transportError:
          _logger.warning('Connection to device lost');
          add(const ConnectionLost());
      }
    });
  }

  void _onConnectionAttemptFailed(
    ConnectionAttemptFailed event,
    Emitter<DeviceSessionState> emit,
  ) {
    emit(NotConnected(error: event.connectionError));
  }

  void _onDisconnectDevice(
    DisconnectDevice event,
    Emitter<DeviceSessionState> emit,
  ) {
    final state = this.state;
    if (state is Connected) {
      state.session.close();
    }

    emit(NotConnected());
  }

  void _connectionLost(ConnectionLost event, Emitter<DeviceSessionState> emit) {
    emit(NotConnected(error: ConnectionError.connectionLost));
  }

  @override
  Future<void> close() async {
    final state = this.state;
    if (state is Connected) {
      await state.session.close();
    }
    return super.close();
  }
}
