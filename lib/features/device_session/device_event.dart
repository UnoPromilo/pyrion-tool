import '../../shared/units/temperature.dart';

sealed class DeviceEvent {
  const DeviceEvent();
}

final class TelemetryEvent extends DeviceEvent {
  const TelemetryEvent({required this.cpuTemperature});

  final Temperature cpuTemperature;

  @override
  String toString() {
    return 'TelemetryEvent: {CpuTemp: $cpuTemperature}';
  }
}

final class DeviceIntroductionEvent extends DeviceEvent {
  DeviceIntroductionEvent({
    required this.deviceId,
    required this.firmwareVersion,
  });

  final String deviceId;
  final String firmwareVersion;
}
