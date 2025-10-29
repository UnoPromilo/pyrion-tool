import 'dart:async';

import '../../remotes/device_api/generated/pyrion/v1/controller_message.pb.dart';
import '../../remotes/device_api/generated/pyrion/v1/device_message.pb.dart';
import '../device_info/device_data.dart';
import 'device_event.dart';

class DeviceHandle {
  DeviceHandle(this.sink, this.stream);

  final StreamSink<ControllerMessage> sink;
  final Stream<DeviceMessage> stream;
}

class Device {
  Device({required this.deviceData, required this.sink, required this.stream});

  final DeviceData deviceData;
  final StreamSink<ControllerMessage> sink;
  final Stream<DeviceEvent> stream;
}
