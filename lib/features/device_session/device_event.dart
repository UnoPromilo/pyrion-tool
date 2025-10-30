import '../../shared/units/electric_current.dart';
import '../../shared/units/electric_potential.dart';
import '../../shared/units/percentage.dart';
import '../../shared/units/power.dart';
import '../../shared/units/temperature.dart';

sealed class DeviceEvent {
  const DeviceEvent();
}

final class TelemetryEvent extends DeviceEvent {
  const TelemetryEvent({
    required this.currentConsumption,
    required this.dutyCycle,
    required this.motorTemperature,
    required this.powerConsumption,
    required this.uptime,
    required this.vBus,
    required this.cpuTemperature,
  });

  final Temperature cpuTemperature;
  final Temperature motorTemperature;
  final ElectricPotential vBus;
  final Power powerConsumption;
  final ElectricCurrent currentConsumption;
  final Percentage dutyCycle;
  final Duration uptime;

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
