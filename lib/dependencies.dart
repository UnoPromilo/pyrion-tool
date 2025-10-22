import 'package:ioc_container/ioc_container.dart';

import 'features/device_discovery/device_discovery_service.dart';
import 'presentation/blocs/device_discovery/device_discovery_bloc.dart';

IocContainer createIocContainer({
  void Function(IocContainerBuilder)? replaceDependencies,
}) {
  final builder = IocContainerBuilder(allowOverrides: true)
    ..registerBloc()
    ..registerFeatures();

  replaceDependencies?.call(builder);

  return builder.toContainer();
}

extension on IocContainerBuilder {
  void registerBloc() {
    add((c) => DeviceDiscoveryBloc(c()));
  }

  void registerFeatures() {
    registerDeviceDiscovery();
  }

  void registerDeviceDiscovery() {
    add((c) => DeviceDiscoveryService());
  }
}
