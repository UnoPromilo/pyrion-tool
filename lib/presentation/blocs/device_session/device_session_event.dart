part of 'device_session_bloc.dart';

@immutable
sealed class DeviceSessionEvent {}

class ConnectToDevice extends DeviceSessionEvent {
  ConnectToDevice({
    required this.interface,
    required this.connectionString,
    required this.deviceName,
  });

  final String connectionString;
  final String? deviceName;
  final Interface interface;
}

class ConnectedSuccessfully extends DeviceSessionEvent {
  ConnectedSuccessfully(this.session);

  final DeviceSession session;
}

class ConnectionAttemptFailed extends DeviceSessionEvent {
  ConnectionAttemptFailed(this.connectionError);

  final ConnectionError connectionError;
}

class DisconnectDevice implements DeviceSessionEvent {
  const DisconnectDevice();
}

class ConnectionLost implements DeviceSessionEvent {
  const ConnectionLost();
}
