import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../shared/build_context_extensions.dart';
import '../../../styles/app_sizes.dart';
import 'motor_control/apply.dart';
import 'motor_control/control_mode.dart';
import 'motor_control/motor_info.dart';
import 'motor_control/motor_state.dart';
import 'motor_control/target.dart';

class MotorControl extends StatelessWidget {
  const MotorControl({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: AppSizes.paddingCardMedium,
      child: Column(
        spacing: AppSizes.spacingXLarge / 2,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Section(
            title: context.appLocalizations.motorStateTitle,
            content: const MotorStatus(),
          ),
          const SizedBox.shrink(),
          _Section(
            title: context.appLocalizations.motorControlMode,
            content: const Column(
              spacing: AppSizes.spacingLarge,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ControlMode(), Target(), ApplyButton()],
            ),
          ),
          const Divider(height: 0),
          const _Section(content: MotorInfo()),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.content, this.title});

  final String? title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSizes.spacingLarge,
      children: [if (title != null) Text(title!), content],
    );
  }
}
