import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/motor/motor_cubit.dart';
import '../../../../widgets/number_input.dart';

class Target extends StatelessWidget {
  const Target({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotorCubit, MotorState>(
      builder: (context, state) {
        return switch (state) {
          MotorPoweredOff() => const NumberInput(
            key: Key('TargetOff'),
            enabled: false,
            maxValue: 0,
            minValue: 0,
          ),
          VelocityControl(:final target) => NumberInput(
            key: const Key('TargetVelocity'),
            decimalDigits: 0,
            maxValue: 10000,
            // TODO take from config
            minValue: -10000,
            // TODO take from config
            step: 10,
            unit: 'RPM',
            value: target,
            onChanged: (newTarget) => context
                .read<MotorCubit>()
                .setVelocityControl(newTarget.toDouble()),
          ),
          TorqueControl(:final target) => NumberInput(
            key: const Key('TargetTorque'),
            decimalDigits: 3,
            maxValue: 60,
            // TODO take from config
            minValue: -60,
            // TODO take from config
            step: 0.1,
            unit: 'A',
            value: target,
            onChanged: (newTarget) => context
                .read<MotorCubit>()
                .setTorqueControl(newTarget.toDouble()),
          ),
          PositionControl(:final target) => NumberInput(
            key: const Key('TargetPosition'),
            decimalDigits: 2,
            maxValue: 359.999,
            minValue: 0,
            unit: '°',
            value: target,
            onChanged: (newTarget) => context
                .read<MotorCubit>()
                .setPositionControl(newTarget.toDouble()),
          ),
          DutyCycleControl(:final target) => NumberInput(
            key: const Key('TargetDutyCycle'),
            decimalDigits: 2,
            maxValue: 100,
            minValue: -100,
            step: 0.1,
            unit: '%',
            value: target,
            onChanged: (newTarget) => context
                .read<MotorCubit>()
                .setDutyCycleControl(newTarget.toDouble()),
          ),
        };
      },
    );
  }
}
