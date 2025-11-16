import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../shared/build_context_extensions.dart';
import '../../../../blocs/motor/motor_cubit.dart';
import '../../../../styles/app_sizes.dart';
import '../../../../widgets/glass_button.dart';

class ControlMode extends StatelessWidget {
  const ControlMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Row(
          spacing: 5,
          children: [
            _ControlModeItem(
              onTap: () => context.read<MotorCubit>().setVelocityControl(),
              selectedVariant: GlassButtonVariant.green,
              value: const VelocityControl.zero().runtimeType,
              text: context.appLocalizations.modeControlVelocity,
              icon: LucideIcons.gauge,
            ),
            _ControlModeItem(
              onTap: () => context.read<MotorCubit>().setTorqueControl(),
              selectedVariant: GlassButtonVariant.yellow,
              value: const TorqueControl.zero().runtimeType,
              text: context.appLocalizations.modeControlTorque,
              icon: LucideIcons.zap,
            ),
          ],
        ),
        Row(
          spacing: 5,
          children: [
            _ControlModeItem(
              onTap: () => context.read<MotorCubit>().setPositionControl(),
              selectedVariant: GlassButtonVariant.blue,
              value: const PositionControl.zero().runtimeType,
              text: context.appLocalizations.modeControlPosition,
              icon: LucideIcons.gitCommitHorizontal,
            ),
            _ControlModeItem(
              onTap: () => context.read<MotorCubit>().setDutyCycleControl(),
              selectedVariant: GlassButtonVariant.violet,
              value: const DutyCycleControl.zero().runtimeType,
              text: context.appLocalizations.modeControlDuty,
              icon: LucideIcons.percent,
            ),
          ],
        ),
      ],
    );
  }
}

class _ControlModeItem extends StatelessWidget {
  const _ControlModeItem({
    required this.selectedVariant,
    required this.value,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Type value;
  final String text;
  final IconData icon;
  final GlassButtonVariant selectedVariant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MotorCubit, MotorState>(
        builder: (context, state) {
          final enabled = state is! MotorPoweredOff;
          final selected = state.runtimeType == value;

          return GlassButton.variant(
            padding: AppSizes.paddingCardSmall,
            variant: selected && enabled
                ? selectedVariant
                : GlassButtonVariant.gray,
            height: 55,
            enabled: enabled,
            onPressed: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [Icon(icon, size: 18), Text(text)],
            ),
          );
        },
      ),
    );
  }
}
