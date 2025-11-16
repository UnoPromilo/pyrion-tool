part of 'motor_cubit.dart';

@immutable
sealed class MotorState {
  const MotorState();
}

final class MotorPoweredOff extends MotorState {
  const MotorPoweredOff();
}

sealed class MotorPoweredOn extends MotorState {
  const MotorPoweredOn();
}

final class VelocityControl extends MotorPoweredOn {
  const VelocityControl({required this.target});
  const VelocityControl.zero() : target = 0;

  final double target;
}

final class TorqueControl extends MotorPoweredOn {
  const TorqueControl({required this.target});
  const TorqueControl.zero() : target = 0;

  final double target;
}

final class PositionControl extends MotorPoweredOn {
  const PositionControl({required this.target});
  const PositionControl.zero() : target = 0;

  final double target;
}

final class DutyCycleControl extends MotorPoweredOn {
  const DutyCycleControl({required this.target});
  const DutyCycleControl.zero() : target = 0;

  final double target;
}
