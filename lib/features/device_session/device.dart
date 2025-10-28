import 'dart:async';

import '../../remotes/device_api/generated/pyrion/v1/controller_message.pb.dart';
import '../../remotes/device_api/generated/pyrion/v1/device_message.pb.dart';
import '../../shared/interface.dart';

class DeviceHandle {
  DeviceHandle(this.sink, this.stream);

  final StreamSink<ControllerMessage> sink;
  final Stream<DeviceMessage> stream;
}

class Device {
  Device({
    required this.deviceName,
    required this.deviceId,
    required this.firmwareVersion,
    required this.interface,
    required this.handle,
  });

  final String deviceName;
  final String deviceId;
  final String firmwareVersion;
  final Interface interface;
  final DeviceHandle handle;
}
