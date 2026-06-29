import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../features/device_info/device_data.dart';
import '../../../features/device_info/telemetry_data.dart';
import '../../../features/device_session/device_session.dart';

part 'device_info_state.dart';

class DeviceInfoCubit extends Cubit<DeviceInfoState> {
  DeviceInfoCubit(DeviceSession session)
    : super(
        DeviceInfoState(
          deviceData: session.deviceData,
          telemetryData: const TelemetryData.empty(),
        ),
      ) {
    _telemetrySubscription = session.telemetry.listen(_onTelemetry);
  }

  StreamSubscription<TelemetryData>? _telemetrySubscription;

  void _onTelemetry(TelemetryData telemetryData) {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(telemetryData: telemetryData));
  }

  @override
  Future<void> close() async {
    await _telemetrySubscription?.cancel();
    _telemetrySubscription = null;
    return super.close();
  }
}
