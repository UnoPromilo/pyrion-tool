import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../features/device_session/device_event.dart';
import '../../../features/device_session/device_session.dart';

part 'fault_register_state.dart';

class FaultRegisterCubit extends Cubit<FaultRegisterState> {
  FaultRegisterCubit(this.session)
    : super(const FaultRegisterState([])) {
    _faultsSubscription = session.faults.listen(_onFaults);
    session.refreshFaults();
  }

  StreamSubscription<List<FaultEntry>>? _faultsSubscription;
  DeviceSession session;

  void clearResolved(){
    session..resetFaults()
    ..refreshFaults();
  }

  void _onFaults(List<FaultEntry> errors) {
    if (isClosed) {
      return;
    }
    emit(FaultRegisterState(errors));
  }

  @override
  Future<void> close() async {
    await _faultsSubscription?.cancel();
    _faultsSubscription = null;
    return super.close();
  }
}
