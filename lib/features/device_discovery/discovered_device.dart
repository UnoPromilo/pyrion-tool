import '../../shared/interface.dart';

class DiscoveredDevice {
  const DiscoveredDevice({
    required this.interface,
    required this.address,
    required this.connectionString,
    this.name,
    this.firmwareVersion,
  });

  final Interface interface;
  final String address;
  final String connectionString;
  final String? name;
  final String? firmwareVersion;
}
