import 'discovered_device.dart';

class DeviceDiscoveryService {
  Stream<DiscoveredDevice> discover() async* {
    await Future.delayed(const Duration(seconds: 1));
    yield const DiscoveredDevice.serial('/dev/ttyUSB0');
    await Future.delayed(const Duration(seconds: 1));
    yield const DiscoveredDevice.usb(
      'USB0',
      name: 'Rear motor controller',
      firmwareVersion: 'v0.0.1',
    );
    await Future.delayed(const Duration(seconds: 1));
    yield const DiscoveredDevice.can(
      'CAN0:0x10',
      name: 'Front motor controller',
      firmwareVersion: 'v0.0.1',
    );
  }
}
