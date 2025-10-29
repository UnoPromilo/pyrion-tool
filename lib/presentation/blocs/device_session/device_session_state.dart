part of 'device_session_bloc.dart';

@immutable
sealed class DeviceSessionState {}

final class NotConnected extends DeviceSessionState {
  NotConnected({this.error});

  final ConnectionError? error;
}

final class Connecting extends DeviceSessionState {
  Connecting({required this.deviceName});

  final String? deviceName;
}

class Connected extends DeviceSessionState {
  Connected({required this.deviceData, required this.telemetryData});

  final DeviceData deviceData;
  final TelemetryData telemetryData;

  Connected copyWith({TelemetryData? telemetryData}) {
    return Connected(
      deviceData: deviceData,
      telemetryData: telemetryData ?? this.telemetryData,
    );
  }
}
