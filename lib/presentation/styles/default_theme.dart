import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'app_theme.dart';

final ShadThemeData defaultShadThemeData = ShadThemeData(
  brightness: Brightness.dark,
  colorScheme: ShadOrangeColorScheme.dark(
    card: const Color(0xff0c0a09).withAlpha(150),
  ),
);

final AppThemeData defaultAppThemeData = AppThemeData(
  backgroundGradient: const LinearGradient(
    colors: [Color(0xFF5E1005), Color(0xFF8A3908), Color(0xFF5E1005)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  grayTextColor: const Color(0xffb6b6b6),
);
