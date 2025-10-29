import '../../shared/interface.dart';

final class DeviceData {
  const DeviceData({
    required this.deviceName,
    required this.deviceId,
    required this.firmwareVersion,
    required this.interface,
  });

  final String deviceName;
  final String deviceId;
  final String firmwareVersion;
  final Interface interface;
}
