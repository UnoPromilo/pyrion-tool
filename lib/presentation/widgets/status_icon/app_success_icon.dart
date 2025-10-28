import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../styles/app_sizes.dart';
import '../../styles/style_extensions.dart';
import 'app_status_icon.dart';

class AppSuccessIcon extends StatelessWidget {
  const AppSuccessIcon({
    super.key,
    this.size = AppSizes.defaultAppIconSize,
    this.theme,
  });

  final double size;
  final AppStatusIconTheme? theme;

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? context.appTheme.appSuccessIcon;
    return AppStatusIcon(icon: LucideIcons.check, theme: theme);
  }
}
