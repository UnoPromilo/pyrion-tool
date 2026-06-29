import 'dart:core';

import 'package:stream_transform/stream_transform.dart';

import '../../remotes/device_api/client/client.dart';
import '../../remotes/device_api/generated/pyrion/v1/controller_message.pb.dart';
import '../../remotes/device_api/generated/pyrion/v1/device_message.pb.dart'
    hide Failure, Success;
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
import '../device_info/telemetry_data.dart';
import '../device_session/device.dart';
import '../device_session/device_event.dart';
import '../device_session/device_session.dart';
import '../device_session/mappings/fault_register_mapping.dart';

final class DeviceSessionFactory {
  DeviceSessionFactory(this._client);

  final DeviceApiClient _client;

  Future<Result<DeviceSession, ConnectionError>> open({
    required String connectionString,
    required Interface interface,
    String? deviceName,
  }) async {
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

  Future<Result<DeviceSession, ConnectionError>> _onSuccess(
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
    final Result<DeviceSession, ConnectionError> result =
        switch (await deviceIntroductionFuture) {
          Success(:final data) => switch (data) {
            Success(:final data) => Success(
              DeviceSession(
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
}

DeviceEvent? _mapToDeviceEvent(DeviceMessage deviceMessage) {
  return switch (deviceMessage.whichPayload()) {
    DeviceMessage_Payload.deviceIntroduction => DeviceIntroductionEvent(
      deviceId: deviceMessage.deviceIntroduction.uid,
      firmwareVersion: deviceMessage.deviceIntroduction.firmware,
    ),
    DeviceMessage_Payload.telemetry => TelemetryEvent(
      TelemetryData(
        cpuTemperature: Temperature.fromKelvins(
          deviceMessage.telemetry.cpuTemp,
        ),
        driverTemperature: deviceMessage.telemetry.driverTemp == 0
            ? null
            : Temperature.fromKelvins(deviceMessage.telemetry.driverTemp),
        motorTemperature: deviceMessage.telemetry.motorTemp == 0
            ? null
            : Temperature.fromKelvins(deviceMessage.telemetry.motorTemp),
        powerConsumption: Power.fromWatts(deviceMessage.telemetry.power),
        currentConsumption: ElectricCurrent.fromAmperes(
          deviceMessage.telemetry.current,
        ),
        vBus: ElectricPotential.fromVolts(deviceMessage.telemetry.vBus),
        dutyCycle: Percentage.fromFraction(deviceMessage.telemetry.dutyCycle),
        uptime: Duration(milliseconds: deviceMessage.telemetry.uptime.toInt()),
        activeFaults: deviceMessage.telemetry.activeFaults,
        latchedFaults: deviceMessage.telemetry.latchedFaults,
      ),
    ),
    DeviceMessage_Payload.success => null,
    DeviceMessage_Payload.failure => null,
    DeviceMessage_Payload.faultRegister => FaultLogEvent(
      deviceMessage.faultRegister.faults
          .map((e) => e.mapToAppEntity())
          .toList(),
    ),
    _ => null,
  };
}

enum ConnectionError {
  networkError,
  unauthenticated,
  unavailable,
  deviceNotResponding,
  connectionLost,
}
