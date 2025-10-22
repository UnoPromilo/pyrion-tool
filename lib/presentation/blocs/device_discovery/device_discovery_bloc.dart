import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../features/device_discovery/device_discovery_service.dart';
import '../../../features/device_discovery/discovered_device.dart';

part 'device_discovery_event.dart';
part 'device_discovery_state.dart';

class DeviceDiscoveryBloc
    extends Bloc<DeviceDiscoveryEvent, DeviceDiscoveryState> {
  DeviceDiscoveryBloc(this._discoveryService)
    : super(const DeviceDiscoveryIdle(devices: [])) {
    on<RefreshDevices>(
      _onRefresh,
      //transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<NewDeviceDiscovered>(_onNewDeviceDiscovered);
    on<DeviceDiscoveryFinished>(_onDiscoveryFinished);
    add(RefreshDevices());
  }

  final DeviceDiscoveryService _discoveryService;
  StreamSubscription<DiscoveredDevice>? _devicesSubscription;

  void _onRefresh(RefreshDevices event, Emitter<DeviceDiscoveryState> emitter) {
    if (_devicesSubscription != null) {
      return;
    }
    emitter(const DeviceDiscoverySearching(devices: []));

    _devicesSubscription = _discoveryService.discover().listen(
      (device) => add(NewDeviceDiscovered(device)),
    )..onDone(() => add(DeviceDiscoveryFinished()));
  }

  void _onNewDeviceDiscovered(
    NewDeviceDiscovered event,
    Emitter<DeviceDiscoveryState> emit,
  ) {
    emit(
      DeviceDiscoverySearching(
        devices: state.devices.followedBy([event.device]).toList(),
      ),
    );
  }

  void _onDiscoveryFinished(
    DeviceDiscoveryFinished event,
    Emitter<DeviceDiscoveryState> emit,
  ) {
    _devicesSubscription = null;
    emit(DeviceDiscoveryIdle(devices: state.devices));
  }

  @override
  Future<void> close() {
    _devicesSubscription?.cancel();
    return super.close();
  }
}
