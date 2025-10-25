import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';

import '../../../features/device_discovery/discovered_device.dart';
import '../../remote_result.dart';
import '../generated/v1/discovery.pbgrpc.dart' as proto;

class DeviceApiClient {
  factory DeviceApiClient.create({String host = 'localhost', int port = 9999}) {
    final channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final discoveryDeviceClient = proto.DeviceDiscoveryClient(channel);
    return DeviceApiClient._(channel, discoveryDeviceClient);
  }

  DeviceApiClient._(this._channel, this._deviceDiscoveryClient);

  final ClientChannel _channel;
  final proto.DeviceDiscoveryClient _deviceDiscoveryClient;
  final Logger _logger = Logger('DeviceApiClient');

  Future<RemoteResult<List<DiscoveredDevice>>> getAvailableDevices() async {
    try {
      final response = await _deviceDiscoveryClient.listDevices(
        proto.DiscoveryParams(),
      );
      return RemoteResult.success(
        response.devices
            .map(
              (d) => DiscoveredDevice(
                interface: _mapInterface(d.interface),
                address: d.address,
                name: _toNullIfEmpty(d.name),
                firmwareVersion: _toNullIfEmpty(d.firmware),
              ),
            )
            .toList(growable: false),
      );
    } on GrpcError catch (error) {
      _logger.warning(error.toString());
      return RemoteResult.fromGrpcError(error);
    } on UnknownInterfaceException catch (error) {
      _logger.warning(error.toString());
      return RemoteResult.cantMap();
    }
  }

  Future<void> dispose() async {
    await _channel.shutdown();
  }

  static Interface _mapInterface(proto.Interface interface) {
    return switch (interface) {
      proto.Interface.Serial => Interface.serial,
      proto.Interface.Virtual => Interface.virtual,
      _ => throw UnknownInterfaceException(interface),
    };
  }

  static String? _toNullIfEmpty(String value) {
    return value.isEmpty ? null : value;
  }
}

class UnknownInterfaceException implements Exception {
  const UnknownInterfaceException(this.interface);

  final proto.Interface interface;

  @override
  String toString() {
    return 'There is no mapping for interface: ${interface.name}(${interface.value})';
  }
}
