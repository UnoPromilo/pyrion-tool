import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';

import '../../../features/device_discovery/discovered_device.dart';
import '../../../features/device_session/device.dart';
import '../../../shared/interface.dart';
import '../../remote_result.dart';
import '../generated/pyrion/v1/controller_message.pb.dart';
import '../generated/pyrion/v1/discovery.pbgrpc.dart' as proto_discovery;
import '../generated/pyrion/v1/interface.pb.dart' as proto_interface;
import '../generated/pyrion/v1/session.pbgrpc.dart' as proto_session;

const connectionStringMetadataKey = 'connection-string';

class DeviceApiClient {
  factory DeviceApiClient.create({String host = 'localhost', int port = 7985}) {
    final channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final discoveryDeviceClient = proto_discovery.DeviceDiscoveryClient(
      channel,
    );

    final deviceSessionClient = proto_session.DeviceSessionClient(channel);

    return DeviceApiClient._(
      channel,
      discoveryDeviceClient,
      deviceSessionClient,
    );
  }

  DeviceApiClient._(
    this._channel,
    this._deviceDiscoveryClient,
    this._deviceSessionClient,
  );

  final ClientChannel _channel;
  final proto_discovery.DeviceDiscoveryClient _deviceDiscoveryClient;
  final proto_session.DeviceSessionClient _deviceSessionClient;
  final Logger _logger = Logger('DeviceApiClient');

  Future<RemoteResult<List<DiscoveredDevice>>> getAvailableDevices() async {
    try {
      final response = await _deviceDiscoveryClient.listDevices(
        proto_discovery.DiscoveryParams(),
      );
      return RemoteResult.success(
        response.devices
            .map(
              (d) => DiscoveredDevice(
                interface: _mapInterface(d.interface),
                address: d.address,
                connectionString: d.connectionString,
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

  Future<RemoteResult<DeviceHandle>> connectTo(String connectionString) async {
    final inputStream = StreamController<ControllerMessage>();
    try {
      final response = _deviceSessionClient.open(
        inputStream.stream,
        options: CallOptions(
          metadata: {connectionStringMetadataKey: connectionString},
        ),
      );
      return RemoteResult.success(DeviceHandle(inputStream.sink, response));
    } on GrpcError catch (error) {
      await inputStream.close();
      _logger.warning(error.toString());
      return RemoteResult.fromGrpcError(error);
    } on UnknownInterfaceException catch (error) {
      await inputStream.close();
      _logger.warning(error.toString());
      return RemoteResult.cantMap();
    }
    catch (error) {
      await inputStream.close();
      _logger.warning(error.toString());
      return RemoteResult.fromGrpcError(const GrpcError.unknown());
    }
  }

  Future<void> dispose() async {
    await _channel.shutdown();
  }

  static Interface _mapInterface(proto_interface.Interface interface) {
    return switch (interface) {
      proto_interface.Interface.Serial => Interface.serial,
      proto_interface.Interface.Virtual => Interface.virtual,
      _ => throw UnknownInterfaceException(interface),
    };
  }

  static String? _toNullIfEmpty(String value) {
    return value.isEmpty ? null : value;
  }
}

class UnknownInterfaceException implements Exception {
  const UnknownInterfaceException(this.interface);

  final proto_interface.Interface interface;

  @override
  String toString() {
    return 'There is no mapping for interface: ${interface.name}(${interface.value})';
  }
}
