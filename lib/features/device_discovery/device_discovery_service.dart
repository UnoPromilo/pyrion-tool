import '../../remotes/device_api/client/client.dart';
import '../../remotes/remote_result.dart';
import '../../shared/result.dart';
import 'discovered_device.dart';

class DeviceDiscoveryService {
  DeviceDiscoveryService(this.client);

  final DeviceApiClient client;

  Future<Result<List<DiscoveredDevice>, DiscoveryError>> discover() async {
    final result = await client.getAvailableDevices();
    return switch (result) {
      RemoteSuccess(:final data) => Success(data),
      RemoteError(:final error) => Failure(_mapRemoteErrorType(error)),
    };
  }

  DiscoveryError _mapRemoteErrorType(RemoteErrorType error) {
    return switch (error) {
      RemoteErrorType.aborted => DiscoveryError.networkError,
      RemoteErrorType.unavailable => DiscoveryError.unavailable,
      RemoteErrorType.dataLoss => DiscoveryError.networkError,
      RemoteErrorType.unauthenticated => DiscoveryError.unauthenticated,
      RemoteErrorType.cantMap => DiscoveryError.internalError,
      RemoteErrorType.unknown => DiscoveryError.unknown,
    };
  }
}

enum DiscoveryError {
  networkError,
  aborted,
  unauthenticated,
  unavailable,
  internalError,
  unknown,
}
