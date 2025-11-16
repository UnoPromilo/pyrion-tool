import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'motor_state.dart';

class MotorCubit extends Cubit<MotorState> {
  MotorCubit() : super(const MotorPoweredOff());

  // TODO validate all inputs
  // Temporary solution until real control is in place
  void setVelocityControl([double target = 0]) {
    emit(VelocityControl(target: target));
  }

  void setTorqueControl([double target = 0]) {
    emit(TorqueControl(target: target));
  }

  void setPositionControl([double target = 0]) {
    emit(PositionControl(target: target));
  }

  void setDutyCycleControl([double target = 0]) {
    emit(DutyCycleControl(target: target));
  }

  void powerOffMotor() {
    emit(const MotorPoweredOff());
  }
}
