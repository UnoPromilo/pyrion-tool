part of 'device_discovery_bloc.dart';

@immutable
sealed class DeviceDiscoveryState {
  const DeviceDiscoveryState();
}

final class DeviceDiscoverySearching extends DeviceDiscoveryState {
  const DeviceDiscoverySearching();
}

final class DeviceDiscoveryIdle extends DeviceDiscoveryState {
  const DeviceDiscoveryIdle(this.devices);

  final List<DiscoveredDevice> devices;
}

final class DeviceDiscoveryError extends DeviceDiscoveryState {
  const DeviceDiscoveryError(this.error);

  final DiscoveryError error;
}
