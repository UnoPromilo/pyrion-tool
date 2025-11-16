import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../remotes/device_api/client/client.dart';
import '../../remotes/device_api/generated/pyrion/v1/controller_message.pb.dart';
import '../../remotes/device_api/generated/pyrion/v1/device_message.pb.dart'
    hide Success, Failure;
import '../../remotes/device_api/generated/pyrion/v1/device_message.pb.dart'
    as device_message
    show Success, Failure;
import '../../remotes/remote_result.dart';
import '../../shared/future_extensions.dart';
import '../../shared/interface.dart';
import '../../shared/result.dart';
import '../../shared/stream_extensions.dart';
import '../../shared/units/electric_current.dart';
import '../../shared/units/electric_potential.dart';
import '../../shared/units/percentage.dart';
import '../../shared/units/power.dart';
import '../../shared/units/temperature.dart';
import '../device_info/device_data.dart';
import 'device.dart';
import 'device_event.dart';

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
    final broadcastStream = deviceHandle.stream
        .map(_mapToDeviceEvent)
        .asBroadcastStream();

    final deviceIntroductionFuture = broadcastStream
        .whereType<DeviceIntroductionEvent>()
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
                deviceData: DeviceData(
                  deviceName: deviceName ?? 'Generic device',
                  deviceId: data.deviceId,
                  firmwareVersion: data.firmwareVersion,
                  interface: interface,
                ),
                sink: deviceHandle.sink,
                stream: broadcastStream.whereNotNull(),
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

DeviceEvent? _mapToDeviceEvent(DeviceMessage deviceMessage) {
  if (deviceMessage.hasTelemetry()) {
    final data = deviceMessage.telemetry;
    return TelemetryEvent(
      cpuTemperature: Temperature.fromKelvins(data.cpuTemp),
      driverTemperature: data.driverTemp == 0
          ? null
          : Temperature.fromKelvins(data.driverTemp),
      motorTemperature: data.motorTemp == 0
          ? null
          : Temperature.fromKelvins(data.motorTemp),
      powerConsumption: Power.fromWatts(data.power),
      currentConsumption: ElectricCurrent.fromAmperes(data.current),
      vBus: ElectricPotential.fromVolts(data.vBus),
      dutyCycle: Percentage.fromFraction(data.dutyCycle),
      uptime: Duration(milliseconds: data.uptime.toInt()),
    );
  }
  if (deviceMessage.hasDeviceIntroduction()) {
    final data = deviceMessage.deviceIntroduction;
    return DeviceIntroductionEvent(
      deviceId: data.uid,
      firmwareVersion: data.firmware,
    );
  }

  if (kDebugMode) {
    throw Exception('Unknown device message');
  }

  return null;
}

enum ConnectionError {
  networkError,
  unauthenticated,
  unavailable,
  deviceNotResponding,
  connectionLost,
}
