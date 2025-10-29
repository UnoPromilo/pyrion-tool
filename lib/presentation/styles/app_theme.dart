import 'package:flutter/material.dart';

import '../pages/dashboard/widgets/device_info.dart';
import '../widgets/status_icon/app_status_icon.dart';

final class AppThemeData {
  AppThemeData({
    required this.spinnerColor,
    required this.backgroundGradient,
    required this.grayTextColor,
    required this.appStatusIcon,
    required this.appSuccessIcon,
    required this.appErrorIcon,
    required this.motorStateIndicator,
  });

  final Gradient backgroundGradient;
  final Color grayTextColor;
  final Color spinnerColor;
  final AppStatusIconTheme appStatusIcon;
  final AppStatusIconTheme appSuccessIcon;
  final AppStatusIconTheme appErrorIcon;
  final MotorStateIndicatorTheme motorStateIndicator;
}

class AppTheme extends StatelessWidget {
  const AppTheme({required this.data, required this.child, super.key});

  final AppThemeData data;
  final Widget child;

  static AppThemeData of(BuildContext context, {bool listen = true}) {
    final provider = maybeOf(context, listen: listen);
    if (provider == null) {
      throw FlutterError('''
        AppTheme.of() called with a context that does not contain a AppTheme.\n
        No AppTheme ancestor could be found starting from the context that was passed to AppTheme.of(). 
        The context used was: $context''');
    }
    return provider;
  }

  static AppThemeData? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<AppInheritedTheme>()
          ?.theme
          .data;
    }
    final provider = context
        .getElementForInheritedWidgetOfExactType<AppInheritedTheme>()
        ?.widget;

    return (provider as AppInheritedTheme?)?.theme.data;
  }

  @override
  Widget build(BuildContext context) {
    return AppInheritedTheme(theme: this, child: child);
  }
}

class AppInheritedTheme extends InheritedTheme {
  const AppInheritedTheme({
    required this.theme,
    required super.child,
    super.key,
  });

  final AppTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AppTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(AppInheritedTheme oldWidget) =>
      theme.data != oldWidget.theme.data;
}
