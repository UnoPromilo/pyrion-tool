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

final class Connected extends DeviceSessionState {
  Connected(this.device);

  final Device device;
}
