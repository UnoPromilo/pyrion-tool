import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../shared/build_context_extensions.dart';
import '../../../../blocs/motor/motor_cubit.dart';
import '../../../../styles/app_sizes.dart';
import '../../../../widgets/glass_button.dart';

class MotorStatus extends StatelessWidget {
  const MotorStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotorCubit, MotorState>(
      builder: (context, state) {
        return switch (state) {
          MotorPoweredOn() => const _OnButton(),
          MotorPoweredOff() => const _OffButton(),
        };
      },
    );
  }
}

class _OnButton extends StatelessWidget {
  const _OnButton();

  @override
  Widget build(BuildContext context) {
    return _Button(
      icon: LucideIcons.power,
      text: context.appLocalizations.motorStateOn,
      variant: GlassButtonVariant.green,
      onPressed: () {
        context.read<MotorCubit>().powerOffMotor();
      },
    );
  }
}

class _OffButton extends StatelessWidget {
  const _OffButton();

  @override
  Widget build(BuildContext context) {
    return _Button(
      icon: LucideIcons.powerOff,
      text: context.appLocalizations.motorStateOff,
      variant: GlassButtonVariant.red,
      onPressed: () {
        context.read<MotorCubit>().setVelocityControl();
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.icon,
    required this.text,
    required this.variant,
    this.onPressed,
  });

  final String text;
  final IconData icon;
  final GlassButtonVariant variant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassButton.variant(
      variant: variant,
      size: ShadButtonSize.regular,
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
      onPressed: onPressed,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: AppSizes.spacingSmall,
          children: [
            Icon(icon),
            Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
