import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../styles/style_extensions.dart';

class GlassButton extends StatelessWidget {
  const GlassButton({
    required this.child,
    required GlassButtonThemeData this.theme,
    this.onPressed,
    this.size,
    this.padding,
    super.key,
    this.height,
    this.width,
    this.enabled = true,
  }) : variant = null;

  const GlassButton.variant({
    required this.child,
    required GlassButtonVariant this.variant,
    this.onPressed,
    this.size,
    this.padding,
    super.key,
    this.height,
    this.width,
    this.enabled = true,
  }) : theme = null;

  final Widget child;
  final VoidCallback? onPressed;
  final GlassButtonThemeData? theme;
  final GlassButtonVariant? variant;
  final ShadButtonSize? size;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = _getTheme(context);
    return ShadButton(
      onPressed: onPressed,
      size: size,
      padding: padding,
      width: width,
      height: height,
      decoration: ShadDecoration(
        border: theme.border,
        focusedBorder: theme.focusedBorder,
      ),
      foregroundColor: theme.foregroundColor,
      backgroundColor: theme.backgroundColor,
      hoverForegroundColor: theme.hoverForegroundColor,
      hoverBackgroundColor: theme.hoverBackgroundColor,
      pressedForegroundColor: theme.pressedForegroundColor,
      pressedBackgroundColor: theme.pressedBackgroundColor,
      child: child,
      enabled: enabled,
    );
  }

  GlassButtonThemeData _getTheme(BuildContext context) {
    final theme = this.theme;
    if (theme != null) {
      return theme;
    }
    return switch (variant) {
      GlassButtonVariant.green => context.appTheme.glassButton.green,
      GlassButtonVariant.red => context.appTheme.glassButton.red,
      GlassButtonVariant.yellow => context.appTheme.glassButton.yellow,
      GlassButtonVariant.blue => context.appTheme.glassButton.blue,
      GlassButtonVariant.violet => context.appTheme.glassButton.violet,
      GlassButtonVariant.gray => context.appTheme.glassButton.gray,
      null => throw StateError('Not reachable'),
    };
  }
}

class GlassButtonTheme {
  const GlassButtonTheme({
    required this.green,
    required this.red,
    required this.yellow,
    required this.blue,
    required this.violet,
    required this.gray,
  });

  final GlassButtonThemeData green;
  final GlassButtonThemeData red;
  final GlassButtonThemeData yellow;
  final GlassButtonThemeData blue;
  final GlassButtonThemeData violet;
  final GlassButtonThemeData gray;
}

enum GlassButtonVariant { green, red, yellow, blue, violet, gray }

class GlassButtonThemeData {
  const GlassButtonThemeData({
    required this.border,
    required this.focusedBorder,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.hoverBackgroundColor,
    required this.hoverForegroundColor,
    required this.pressedBackgroundColor,
    required this.pressedForegroundColor,
  });

  final ShadBorder border;
  final ShadBorder focusedBorder;

  final Color backgroundColor;
  final Color foregroundColor;

  final Color hoverBackgroundColor;
  final Color hoverForegroundColor;

  final Color pressedBackgroundColor;
  final Color pressedForegroundColor;
}
