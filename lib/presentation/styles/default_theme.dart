import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../pages/dashboard/widgets/device_info.dart';
import '../pages/dashboard/widgets/motor_control/motor_info.dart';
import '../pages/dashboard/widgets/statistics.dart';
import '../widgets/glass_button.dart';
import '../widgets/status_icon/app_status_icon.dart';
import '../widgets/three_section_layout.dart';
import 'app_sizes.dart';
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
  outlineButtonTheme: ShadButtonTheme(
    foregroundColor: const Color(0xFFFFFFFF),
    decoration: ShadDecoration(
      border: ShadBorder.all(
        width: 1,
        color: const Color(0xFF737373),
        radius: const BorderRadius.all(Radius.circular(5)),
      ),
    ),
  ),
  decoration: ShadDecoration(
    border: ShadBorder.all(
      width: 1,
      color: const Color(0xFF737373),
      radius: const BorderRadius.all(Radius.circular(5)),
    ),
  ),
  inputTheme: ShadInputTheme(
    decoration: ShadDecoration(
      border: ShadBorder.all(
        width: 1,
        color: const Color(0xFF737373),
        radius: const BorderRadius.all(Radius.circular(5)),
      ),
    ),
  ),
);

final AppThemeData defaultAppThemeData = AppThemeData(
  backgroundGradient: const LinearGradient(
    colors: [Color(0xFF5E1005), Color(0xFF8A3908), Color(0xFF5E1005)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  grayTextColor: const Color(0xFFB6B6B6),
  spinnerColor: const Color(0xFFFFFFFF),
  appErrorIcon: const AppStatusIconTheme(
    backgroundColor: Color(0x33FB2C36),
    color: Color(0xFFFB2C36),
  ),
  appSuccessIcon: const AppStatusIconTheme(
    backgroundColor: Color(0x333A9002),
    color: Color(0xFF3A9002),
  ),
  appStatusIcon: const AppStatusIconTheme(
    backgroundColor: Color(0x33FFFFFF),
    color: Color(0xFFFFFFFF),
  ),
  motorStateIndicator: const MotorStateIndicatorTheme(
    powered: Color(0xFF3A9002),
    idle: Color(0xFFFB2C36),
  ),
  statistics: const StatisticsTheme(
    motorTemp: Colors.orange,
    cpuTemp: Colors.orange,
    driverTemp: Colors.orange,
    vBus: Colors.green,
    power: Colors.lightBlue,
    current: Colors.red,
    dutyCycle: Colors.teal,
  ),
  threeSectionLayoutTheme: const ThreeSectionLayoutTheme(
    sectionSpacing: AppSizes.spacingMedium,
    dividerThickness: 2,
    dividerColor: Color(0x1AFFFFFF),
  ),
  glassButton: GlassButtonTheme(
    green: GlassButtonThemeData(
      border: ShadBorder.all(width: 1, color: const Color(0xFF05DF72)),
      focusedBorder: ShadBorder.all(width: 1, color: const Color(0xFF05DF72)),
      backgroundColor: const Color(0x3305DF72),
      foregroundColor: const Color(0xFF05DF72),
      hoverBackgroundColor: const Color(0x6605DF72),
      hoverForegroundColor: const Color(0xFFFFFFFF),
      pressedBackgroundColor: const Color(0x9905DF72),
      pressedForegroundColor: const Color(0xFFFFFFFF),
    ),
    red: GlassButtonThemeData(
      border: ShadBorder.all(width: 1, color: const Color(0xFFFB2C36)),
      focusedBorder: ShadBorder.all(width: 1, color: const Color(0xFFFB2C36)),
      backgroundColor: const Color(0x33C55051),
      foregroundColor: const Color(0xFFFB2C36),
      hoverBackgroundColor: const Color(0x66C55051),
      hoverForegroundColor: const Color(0xFFFFFFFF),
      pressedBackgroundColor: const Color(0x99C55051),
      pressedForegroundColor: const Color(0xFFFFFFFF),
    ),
    yellow: GlassButtonThemeData(
      border: ShadBorder.all(width: 1, color: const Color(0xFFFFB900)),
      focusedBorder: ShadBorder.all(width: 1, color: const Color(0xFFFFB900)),
      backgroundColor: const Color(0x33FFE900),
      foregroundColor: const Color(0xFFFFB900),
      hoverBackgroundColor: const Color(0x66FFE900),
      hoverForegroundColor: const Color(0xFFFFFFFF),
      pressedBackgroundColor: const Color(0x99FFE900),
      pressedForegroundColor: const Color(0xFFFFFFFF),
    ),
    blue: GlassButtonThemeData(
      border: ShadBorder.all(width: 1, color: const Color(0xFF007BE5)),
      focusedBorder: ShadBorder.all(width: 1, color: const Color(0xFF007BE5)),
      backgroundColor: const Color(0x33007A96),
      foregroundColor: const Color(0xFF007BE5),
      hoverBackgroundColor: const Color(0x66007A96),
      hoverForegroundColor: const Color(0xFFFFFFFF),
      pressedBackgroundColor: const Color(0x99007A96),
      pressedForegroundColor: const Color(0xFFFFFFFF),
    ),
    violet: GlassButtonThemeData(
      border: ShadBorder.all(width: 1, color: const Color(0xFFAD46FF)),
      focusedBorder: ShadBorder.all(width: 1, color: const Color(0xFFAD46FF)),
      backgroundColor: const Color(0x3359168B),
      foregroundColor: const Color(0xFFAD46FF),
      hoverBackgroundColor: const Color(0x6659168B),
      hoverForegroundColor: const Color(0xFFFFFFFF),
      pressedBackgroundColor: const Color(0x9959168B),
      pressedForegroundColor: const Color(0xFFFFFFFF),
    ),
    gray: GlassButtonThemeData(
      border: ShadBorder.all(width: 1, color: const Color(0xFF737373)),
      focusedBorder: ShadBorder.all(width: 1, color: const Color(0xFF737373)),
      backgroundColor: const Color(0x0D8D8D8D),
      foregroundColor: const Color(0xFF737373),
      hoverBackgroundColor: const Color(0x1A8D8D8D),
      hoverForegroundColor: const Color(0xFF737373),
      pressedBackgroundColor: const Color(0xD08D8D8D),
      pressedForegroundColor: const Color(0xFF737373),
    ),
  ),
  motorControlInfo: const MotorControlInfoTheme(
    backgroundColor: Color(0x40000000),
    targetColor: Colors.orange,
    actualColor: Color(0xFF05DF72),
  ),
);
