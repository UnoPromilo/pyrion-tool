import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../shared/build_context_extensions.dart';
import '../../../styles/app_sizes.dart';
import 'motor_control/control_mode.dart';
import 'motor_control/motor_state.dart';

class MotorControl extends StatelessWidget {
  const MotorControl({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: AppSizes.paddingCardMedium,
      child: Column(
        spacing: AppSizes.spacingXLarge,
        mainAxisSize: MainAxisSize.min,
        children: [
          _Section(
            title: context.appLocalizations.motorStateTitle,
            content: const MotorStatus(),
          ),
          _Section(
            title: context.appLocalizations.motorControlMode,
            content: const ControlMode(),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.content, required this.title});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSizes.spacingLarge,
      children: [Text(title), content],
    );
  }
}
