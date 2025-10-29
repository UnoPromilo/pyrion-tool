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
  ConnectedSuccessfully(this.device);

  final Device device;
}

class ConnectionAttemptFailed extends DeviceSessionEvent {
  ConnectionAttemptFailed(this.connectionError);

  final ConnectionError connectionError;
}

class DisconnectDevice implements DeviceSessionEvent {
  const DisconnectDevice(this.eventOrigin);

  final Origin eventOrigin;
}

class UpdateTelemetry implements DeviceSessionEvent {
  UpdateTelemetry(this.telemetryData);

  final TelemetryData telemetryData;
}
