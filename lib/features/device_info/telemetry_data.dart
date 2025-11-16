import '../../shared/units/electric_current.dart';
import '../../shared/units/electric_potential.dart';
import '../../shared/units/percentage.dart';
import '../../shared/units/power.dart';
import '../../shared/units/temperature.dart';

final class TelemetryData {
  const TelemetryData({
    required this.currentConsumption,
    required this.dutyCycle,
    required this.motorTemperature,
    required this.powerConsumption,
    required this.uptime,
    required this.vBus,
    required this.cpuTemperature,
    required this.driverTemperature,
  });

  const TelemetryData.empty()
    : cpuTemperature = const Temperature.fromKelvins(0),
      driverTemperature = const Temperature.fromKelvins(0),
      motorTemperature = const Temperature.fromKelvins(0),
      vBus = const ElectricPotential.fromVolts(0),
      powerConsumption = const Power.fromWatts(0),
      currentConsumption = const ElectricCurrent.fromAmperes(0),
      dutyCycle = const Percentage.fromFraction(0),
      uptime = Duration.zero;

  final Temperature cpuTemperature;
  final Temperature? driverTemperature;
  final Temperature? motorTemperature;
  final ElectricPotential vBus;
  final Power powerConsumption;
  final ElectricCurrent currentConsumption;

  final Percentage dutyCycle;

  final Duration uptime;
}
