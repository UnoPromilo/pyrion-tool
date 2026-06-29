import 'dart:async';

import 'package:stream_transform/stream_transform.dart';

import '../../remotes/device_api/generated/pyrion/v1/controller_message.pb.dart';
import '../device_info/device_data.dart';
import '../device_info/telemetry_data.dart';
import 'device.dart';
import 'device_event.dart';

final class DeviceSession {
  DeviceSession(this._device) {
    _sub = _device.stream.listen(
      _events.add,
      onError: (Object e, StackTrace st) {
        _events.addError(e, st);
        _completeDone(SessionEndReason.transportError, e, st);
      },
      onDone: () => _completeDone(SessionEndReason.remoteClosed),
      cancelOnError: false,
    );
  }

  late final StreamSubscription<DeviceEvent> _sub;
  final StreamController<DeviceEvent> _events = StreamController.broadcast();
  final Completer<SessionEndReason> _doneCompleter = Completer();
  final Device _device;
  bool _closed = false;

  bool get isAlive => !_doneCompleter.isCompleted;

  DeviceData get deviceData => _device.deviceData;

  Stream<TelemetryData> get telemetry =>
      _device.stream.whereType<TelemetryEvent>().map((e) => e.data);

  Stream<List<FaultEntry>> get faults =>
      _device.stream.whereType<FaultLogEvent>().map((e) => e.faults);

  Future<SessionEndReason> get done => _doneCompleter.future;

  void refreshFaults() {
    _throwIfNotAlive();

    _device.sink.add(ControllerMessage(reportFaults: ReportFaults()));
  }

  void resetFaults() {
    _throwIfNotAlive();

    _device.sink.add(ControllerMessage(resetFaults: ResetFaults()));
  }

  void _completeDone(SessionEndReason reason, [Object? error, StackTrace? st]) {
    if (_doneCompleter.isCompleted) {
      return;
    }
    _doneCompleter.complete(reason);
  }

  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;
    _completeDone(SessionEndReason.localClose);
    await _sub.cancel();
    await _device.sink.close();
    await _events.close();
  }

  void _throwIfNotAlive() {
    if (!isAlive) {
      throw Exception('DeviceSession is not alive');
    }
  }
}

enum SessionEndReason { remoteClosed, transportError, localClose }
