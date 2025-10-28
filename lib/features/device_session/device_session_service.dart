import 'dart:core';

import '../../remotes/device_api/client/client.dart';
import '../../remotes/device_api/generated/pyrion/v1/controller_message.pb.dart';
import '../../remotes/remote_result.dart';
import '../../shared/future_extensions.dart';
import '../../shared/interface.dart';
import '../../shared/result.dart';
import '../../shared/stream_extensions.dart';
import 'device.dart';

class DeviceSessionService {
  DeviceSessionService(this._client);

  final DeviceApiClient _client;

  Future<Result<Device, ConnectionError>> connect(
    String connectionString,
    Interface interface,
    String? deviceName,
  ) async {
    final result = await _client.connectTo(connectionString);
    return switch (result) {
      RemoteSuccess(:final data) => await _onSuccess(
        data,
        interface,
        deviceName,
      ),
      RemoteError(:final error) => Failure(_mapRemoteErrorType(error)),
    };
  }

  ConnectionError _mapRemoteErrorType(RemoteErrorType error) {
    return switch (error) {
      RemoteErrorType.aborted => ConnectionError.networkError,
      RemoteErrorType.unavailable => ConnectionError.unavailable,
      RemoteErrorType.dataLoss => ConnectionError.networkError,
      RemoteErrorType.unauthenticated => ConnectionError.unauthenticated,
      RemoteErrorType.cantMap => ConnectionError.unavailable,
      RemoteErrorType.unknown => ConnectionError.unavailable,
    };
  }

  Future<Result<Device, ConnectionError>> _onSuccess(
    DeviceHandle deviceHandle,
    Interface interface,
    String? deviceName,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final broadcastStream = deviceHandle.stream.asBroadcastStream();

    final deviceIntroductionFuture = broadcastStream
        .where((e) => e.hasDeviceIntroduction())
        .map((e) => e.deviceIntroduction)
        .tryFirst
        .failingTimeout(const Duration(seconds: 5));

    deviceHandle.sink.add(
      ControllerMessage(introduceYourself: IntroduceYourself()),
    );

    // ignore: omit_local_variable_types
    final Result<Device, ConnectionError> result =
        switch (await deviceIntroductionFuture) {
          Success(:final data) => switch (data) {
            Success(:final data) => Success(
              Device(
                deviceName: deviceName ?? 'Generic device',
                deviceId: data.uid,
                firmwareVersion: data.firmware,
                interface: interface,
                handle: DeviceHandle(deviceHandle.sink, broadcastStream),
              ),
            ),
            Failure() => const Failure(ConnectionError.deviceNotResponding),
          },
          Failure() => const Failure(ConnectionError.deviceNotResponding),
        };

    if (result is Failure) {
      await deviceHandle.sink.close();
    }

    return result;
  }
}

enum ConnectionError {
  networkError,
  unauthenticated,
  unavailable,
  deviceNotResponding,
}
