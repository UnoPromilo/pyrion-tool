import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'app_theme.dart';

extension TextStyle on BuildContext {
  ShadTextTheme get text => ShadTheme.of(this).textTheme;

  AppThemeData get appTheme => AppTheme.of(this);

  ShadThemeData get shadTheme => ShadTheme.of(this);
}
