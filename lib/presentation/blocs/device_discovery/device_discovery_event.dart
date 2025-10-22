part of 'device_discovery_bloc.dart';

@immutable
sealed class DeviceDiscoveryEvent {}

final class RefreshDevices extends DeviceDiscoveryEvent {}

final class NewDeviceDiscovered extends DeviceDiscoveryEvent {
  NewDeviceDiscovered(this.device);

  final DiscoveredDevice device;
}

final class DeviceDiscoveryFinished extends DeviceDiscoveryEvent {
  DeviceDiscoveryFinished();
}
