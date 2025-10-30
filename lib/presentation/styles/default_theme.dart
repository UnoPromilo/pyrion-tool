import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../pages/dashboard/widgets/device_info.dart';
import '../pages/dashboard/widgets/statistics.dart';
import '../widgets/status_icon/app_status_icon.dart';
import 'app_theme.dart';

final ShadThemeData defaultShadThemeData = ShadThemeData(
  brightness: Brightness.dark,
  colorScheme: const ShadOrangeColorScheme.dark(card: Color(0x990c0a10)),
  buttonSizesTheme: const ShadButtonSizesTheme(
    sm: ShadButtonSizeTheme(
      height: 30,
      padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 20),
    ),
  ),
  outlineButtonTheme: const ShadButtonTheme(foregroundColor: Color(0xFFFFFFFF)),
);

const AppThemeData defaultAppThemeData = AppThemeData(
  backgroundGradient: LinearGradient(
    colors: [Color(0xFF5E1005), Color(0xFF8A3908), Color(0xFF5E1005)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  grayTextColor: Color(0xFFB6B6B6),
  spinnerColor: Color(0xFFFFFFFF),
  appErrorIcon: AppStatusIconTheme(
    backgroundColor: Color(0x33FB2C36),
    color: Color(0xFFFB2C36),
  ),
  appSuccessIcon: AppStatusIconTheme(
    backgroundColor: Color(0x333A9002),
    color: Color(0xFF3A9002),
  ),
  appStatusIcon: AppStatusIconTheme(
    backgroundColor: Color(0x33FFFFFF),
    color: Color(0xFFFFFFFF),
  ),
  motorStateIndicator: MotorStateIndicatorTheme(
    powered: Color(0xFF3A9002),
    idle: Color(0xFFFB2C36),
  ),
  statistics: StatisticsTheme(
    motorTemp: Colors.orange,
    cpuTemp: Colors.orange,
    vBus: Colors.green,
    power: Colors.lightBlue,
    current: Colors.red,
    dutyCycle: Colors.teal,
  ),
);
