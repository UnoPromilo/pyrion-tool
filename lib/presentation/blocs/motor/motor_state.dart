part of 'motor_cubit.dart';

@immutable
sealed class MotorState {}

final class MotorPoweredOff extends MotorState {}

sealed class MotorPoweredOn extends MotorState {}

final class VelocityControl extends MotorPoweredOn {}

final class TorqueControl extends MotorPoweredOn {}

final class PositionControl extends MotorPoweredOn {}
