import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../features/device_discovery/device_discovery_service.dart';
import '../../../features/device_discovery/discovered_device.dart';
import '../../../shared/result.dart';

part 'device_discovery_event.dart';

part 'device_discovery_state.dart';

class DeviceDiscoveryBloc
    extends Bloc<DeviceDiscoveryEvent, DeviceDiscoveryState> {
  DeviceDiscoveryBloc(this._discoveryService)
    : super(const DeviceDiscoveryIdle([])) {
    on<RefreshDevices>(
      _onRefresh,
    );
    on<NewDevicesDiscovered>(_onNewDevicesDiscovered);
    on<RefreshingFailed>(_onRefreshingFailed);
    add(RefreshDevices());
  }

  final DeviceDiscoveryService _discoveryService;

  Future _onRefresh(
    RefreshDevices event,
    Emitter<DeviceDiscoveryState> emitter,
  ) async {
    if (state is DeviceDiscoverySearching) {
      return;
    }
    emitter(const DeviceDiscoverySearching());

    final result = await _discoveryService.discover();

    switch (result) {
      case Success(:final data):
        add(NewDevicesDiscovered(data));
      case Failure(:final error):
        add(RefreshingFailed(error));
    }
  }

  void _onNewDevicesDiscovered(
    NewDevicesDiscovered event,
    Emitter<DeviceDiscoveryState> emit,
  ) {
    emit(DeviceDiscoveryIdle(event.devices));
  }

  void _onRefreshingFailed(
    RefreshingFailed event,
    Emitter<DeviceDiscoveryState> emit,
  ) {
    emit(DeviceDiscoveryError(event.error));
  }
}
