import 'package:ioc_container/ioc_container.dart';

import 'features/device_discovery/device_discovery_service.dart';
import 'features/device_session/device_session_service.dart';
import 'presentation/blocs/device_discovery/device_discovery_bloc.dart';
import 'presentation/blocs/device_session/device_session_bloc.dart';
import 'remotes/device_api/client/client.dart';

IocContainer createIocContainer({
  void Function(IocContainerBuilder)? replaceDependencies,
}) {
  final builder = IocContainerBuilder(allowOverrides: true)
    ..registerBloc()
    ..registerFeatures()
    ..registerRemotes();

  replaceDependencies?.call(builder);

  return builder.toContainer();
}

extension on IocContainerBuilder {
  void registerBloc() {
    add((c) => DeviceDiscoveryBloc(c()));
    add((c) => DeviceSessionBloc(c()));
  }

  void registerFeatures() {
    registerDeviceDiscovery();
    registerDeviceSession();
  }

  void registerDeviceDiscovery() {
    add((c) => DeviceDiscoveryService(c()));
  }

  void registerDeviceSession() {
    add((c) => DeviceSessionService(c()));
  }

  void registerRemotes() {
    // TODO allow to change address and port
    addSingleton((c) => DeviceApiClient.create());
  }
}
