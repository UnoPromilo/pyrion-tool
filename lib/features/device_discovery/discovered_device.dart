class DiscoveredDevice {
  const DiscoveredDevice({
    required this.interface,
    required this.address,
    this.name,
    this.firmwareVersion,
  });

  final Interface interface;
  final String address;
  final String? name;
  final String? firmwareVersion;
}

enum Interface { serial, usb, can, virtual }
