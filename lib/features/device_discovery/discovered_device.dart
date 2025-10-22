class DiscoveredDevice {
  // It is not possible to determine with 100% accuracy if serial device is our controller so we can't ask about firmware version and device name
  const DiscoveredDevice.serial(this.address)
    : connectionType = ConnectionType.serial,
      name = null,
      firmwareVersion = null;

  const DiscoveredDevice.usb(
    this.address, {
    required String this.name,
    required String this.firmwareVersion,
  }) : connectionType = ConnectionType.usb;

  const DiscoveredDevice.can(
    this.address, {
    required String this.name,
    required String this.firmwareVersion,
  }) : connectionType = ConnectionType.can;

  final ConnectionType connectionType;
  final String address;
  final String? name;
  final String? firmwareVersion;
}

enum ConnectionType { serial, usb, can }
