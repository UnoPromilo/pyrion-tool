import '../../../remotes/device_api/generated/pyrion/v1/device_message.pb.dart'
    as device_message;
import '../device_event.dart';

extension FaultRegisterMapping on device_message.FaultEntry {
  FaultEntry mapToAppEntity() {
    final faultType = switch (this.type) {
      device_message.FaultType.ENCODER => FaultType.encoder,
      _ => throw Exception('Unknown error type'),
    };

    final faultState = switch (this.state) {
      device_message.FaultState.ACTIVE => FaultState.ongoing,
      device_message.FaultState.LATCHED => FaultState.latched,
      _ => throw Exception('Unknown error value'),
    };

    return FaultEntry(faultType, faultState);
  }
}
