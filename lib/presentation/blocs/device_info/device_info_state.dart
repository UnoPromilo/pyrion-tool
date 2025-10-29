part of 'device_info_cubit.dart';

@immutable
final class DeviceInfoState {
  const DeviceInfoState({
    required this.deviceData,
    required this.telemetryData,
  });

  final DeviceData deviceData;
  final TelemetryData telemetryData;

  DeviceInfoState copyWith({TelemetryData? telemetryData}) {
    return DeviceInfoState(
      deviceData: deviceData,
      telemetryData: telemetryData ?? this.telemetryData,
    );
  }
}
