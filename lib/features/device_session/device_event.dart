import '../device_info/telemetry_data.dart';

sealed class DeviceEvent {
  const DeviceEvent();
}

final class TelemetryEvent extends DeviceEvent {
  const TelemetryEvent(this.data);

  final TelemetryData data;

  @override
  String toString() {
    return 'TelemetryEvent: {CpuTemp: ${data.cpuTemperature}}';
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

final class FaultLogEvent extends DeviceEvent {
  FaultLogEvent(this.faults);

  final List<FaultEntry> faults;

  @override
  String toString() {
    return 'FaultLogsEvent {Count: ${faults.length}';
  }
}

final class FaultEntry {
  FaultEntry(this.type, this.state);

  final FaultType type;
  final FaultState state;
}

enum FaultType { encoder }

enum FaultState { ongoing, latched }
