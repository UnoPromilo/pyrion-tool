part of 'device_discovery_bloc.dart';

@immutable
sealed class DeviceDiscoveryEvent {}

final class RefreshDevices extends DeviceDiscoveryEvent {}

final class NewDevicesDiscovered extends DeviceDiscoveryEvent {
  NewDevicesDiscovered(this.devices);

  final List<DiscoveredDevice> devices;
}

final class RefreshingFailed extends DeviceDiscoveryEvent {
  RefreshingFailed(this.error);

  final DiscoveryError error;
}
