import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../features/device_info/device_data.dart';
import '../../../features/device_info/telemetry_data.dart';

part 'device_info_state.dart';

class DeviceInfoCubit extends Cubit<DeviceInfoState> {
  DeviceInfoCubit(DeviceData deviceData)
    : super(
        DeviceInfoState(
          deviceData: deviceData,
          telemetryData: const TelemetryData.empty(),
        ),
      );

  void updateTelemetry(TelemetryData telemetryData) {
    emit(state.copyWith(telemetryData: telemetryData));
  }
}
