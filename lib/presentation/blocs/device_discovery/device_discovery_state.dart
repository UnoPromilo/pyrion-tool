part of 'device_discovery_bloc.dart';

@immutable
sealed class DeviceDiscoveryState {
  const DeviceDiscoveryState({required this.devices});

  final List<DiscoveredDevice> devices;
}

final class DeviceDiscoverySearching extends DeviceDiscoveryState {
  const DeviceDiscoverySearching({required super.devices});
}

final class DeviceDiscoveryIdle extends DeviceDiscoveryState {
  const DeviceDiscoveryIdle({required super.devices});
}
