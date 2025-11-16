import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../shared/build_context_extensions.dart';
import '../../../../styles/app_sizes.dart';
import '../../../../styles/style_extensions.dart';

class MotorInfo extends StatelessWidget {
  const MotorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSizes.spacingMedium,
      children: [
        _Container(
          title: context.appLocalizations.motorControlInfoTarget,
          value: '0 RPM',
          color: context.appTheme.motorControlInfo.targetColor,
        ),
        _Container(
          title: context.appLocalizations.motorControlInfoActual,
          value: '90,000 RPM',
          color: context.appTheme.motorControlInfo.actualColor,
        ),
      ],
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: context.appTheme.motorControlInfo.backgroundColor,
          borderRadius: context.shadTheme.decoration.border?.radius,
          border: context.shadTheme.decoration.border?.toBorder(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,

              style: TextStyle(
                fontSize: 12,
                color: context.appTheme.grayTextColor,
              ),
            ),
            Text(value, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}

class MotorControlInfoTheme {
  const MotorControlInfoTheme({
    required this.backgroundColor,
    required this.actualColor,
    required this.targetColor,
  });

  final Color backgroundColor;
  final Color targetColor;
  final Color actualColor;
}
