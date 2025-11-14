import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'motor_state.dart';

class MotorCubit extends Cubit<MotorState> {
  MotorCubit() : super(MotorPoweredOff());

  // Temporary solution until real control is in place
  void setVelocityControl() {
    emit(VelocityControl());
  }

  void setTorqueControl() {
    emit(TorqueControl());
  }

  void setPositionControl() {
    emit(PositionControl());
  }

  void powerOffMotor() {
    emit(MotorPoweredOff());
  }
}
