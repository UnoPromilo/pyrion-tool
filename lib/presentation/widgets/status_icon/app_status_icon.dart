import 'package:flutter/material.dart';

import '../../styles/app_sizes.dart';
import '../../styles/style_extensions.dart';

class AppStatusIcon extends StatelessWidget {
  const AppStatusIcon({
    required this.icon,
    super.key,
    this.size = AppSizes.defaultAppIconSize,
    this.theme,
  });

  final double size;
  final AppStatusIconTheme? theme;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? context.appTheme.appStatusIcon;
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: theme.backgroundColor,
        ),
        child: Icon(icon, size: size * 3 / 5, color: theme.color),
      ),
    );
  }
}

class AppStatusIconTheme {
  AppStatusIconTheme({required this.backgroundColor, required this.color});

  final Color backgroundColor;
  final Color color;
}
