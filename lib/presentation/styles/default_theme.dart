import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../pages/dashboard/widgets/device_info.dart';
import '../widgets/status_icon/app_status_icon.dart';
import 'app_theme.dart';

final ShadThemeData defaultShadThemeData = ShadThemeData(
  brightness: Brightness.dark,
  colorScheme: ShadOrangeColorScheme.dark(
    card: const Color(0xff0c0a09).withAlpha(150),
  ),
  buttonSizesTheme: const ShadButtonSizesTheme(
    sm: ShadButtonSizeTheme(
      height: 30,
      padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 20),
    ),
  ),
  outlineButtonTheme: const ShadButtonTheme(foregroundColor: Color(0xFFFFFFFF)),
);

final AppThemeData defaultAppThemeData = AppThemeData(
  backgroundGradient: const LinearGradient(
    colors: [Color(0xFF5E1005), Color(0xFF8A3908), Color(0xFF5E1005)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  grayTextColor: const Color(0xFFB6B6B6),
  spinnerColor: const Color(0xFFFFFFFF),
  appErrorIcon: AppStatusIconTheme(
    backgroundColor: const Color(0x33FB2C36),
    color: const Color(0xFFFB2C36),
  ),
  appSuccessIcon: AppStatusIconTheme(
    backgroundColor: const Color(0x333A9002),
    color: const Color(0xFF3A9002),
  ),
  appStatusIcon: AppStatusIconTheme(
    backgroundColor: const Color(0x33FFFFFF),
    color: const Color(0xFFFFFFFF),
  ),
  motorStateIndicator: MotorStateIndicatorTheme(
    powered: const Color(0xFF3A9002),
    idle: const Color(0xFFFB2C36),
  ),
);
