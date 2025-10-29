import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../shared/build_context_extensions.dart';
import '../../../../shared/divisible.dart';
import '../../../../shared/units/electric_current.dart';
import '../../../../shared/units/electric_potential.dart';
import '../../../../shared/units/percentage.dart';
import '../../../../shared/units/power.dart';
import '../../../../shared/units/temperature.dart';
import '../../../styles/app_sizes.dart';
import '../../../styles/style_extensions.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme.statistics;
    final appLocalizations = context.appLocalizations;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingSmall),
      child: Row(
        spacing: AppSizes.spacingSmall,
        children: [
          _Statistic(
            iconColor: theme.motorTemp,
            icon: LucideIcons.thermometer,
            name: appLocalizations.statisticsMotorTemp,
            value: const Temperature.fromKelvins(300),
          ),
          _Statistic(
            iconColor: theme.cpuTemp,
            icon: LucideIcons.cpu,
            name: appLocalizations.statisticsCpuTemp,
            value: const Temperature.fromKelvins(300),
          ),
          _Statistic(
            iconColor: theme.vBus,
            icon: LucideIcons.battery,
            name: appLocalizations.statisticsVBus,
            value: const ElectricPotential.fromVolts(12.2),
          ),
          _Statistic(
            iconColor: theme.power,
            icon: LucideIcons.power,
            name: appLocalizations.statisticsPower,
            value: const Power.fromWatts(244),
          ),
          _StatisticWithBar(
            color: theme.current,
            icon: LucideIcons.zap,
            name: appLocalizations.statisticsCurrent,
            value: const ElectricCurrent.fromAmperes(20),
            maxValue: const ElectricCurrent.fromAmperes(30),
          ),
          _StatisticWithBar(
            color: theme.dutyCycle,
            icon: LucideIcons.percent,
            name: appLocalizations.statisticsDutyCycle,
            value: const Percentage.fromPercents(80),
            maxValue: const Percentage.fromFraction(1),
          ),
        ],
      ),
    );
  }
}

class _Statistic<T> extends StatelessWidget {
  const _Statistic({
    required this.iconColor,
    required this.icon,
    required this.name,
    required this.value,
  });

  final String name;
  final IconData icon;
  final Color iconColor;
  final T value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShadCard(
        padding: const EdgeInsetsGeometry.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 13, color: iconColor),
                const SizedBox(width: AppSizes.spacingSmall),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.appTheme.grayTextColor,
                  ),
                ),
              ],
            ),
            Text(value.toString()),
          ],
        ),
      ),
    );
  }
}

class _StatisticWithBar<T extends SelfDivisible<T>> extends StatelessWidget {
  const _StatisticWithBar({
    required this.maxValue,
    required this.color,
    required this.icon,
    required this.name,
    required this.value,
  });

  final String name;
  final IconData icon;
  final Color color;
  final T value;
  final T maxValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShadCard(
        padding: const EdgeInsetsGeometry.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 13, color: color),
                const SizedBox(width: AppSizes.spacingSmall),
                Expanded(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.appTheme.grayTextColor,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spacingSmall),
                Text(value.toString(), style: const TextStyle(fontSize: 11)),
              ],
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: (value / maxValue).fraction,
              minHeight: 8,
              color: color,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class StatisticsTheme {
  StatisticsTheme({
    required this.motorTemp,
    required this.cpuTemp,
    required this.vBus,
    required this.power,
    required this.current,
    required this.dutyCycle,
  });

  final Color motorTemp;
  final Color cpuTemp;
  final Color vBus;
  final Color power;
  final Color current;
  final Color dutyCycle;
}
