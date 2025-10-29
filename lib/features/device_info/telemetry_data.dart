import '../../shared/units/temperature.dart';

final class TelemetryData {
  const TelemetryData({required this.cpuTemp});

  const TelemetryData.empty() : cpuTemp = const Temperature.fromKelvins(0);

  final Temperature cpuTemp;
}
