import 'package:ioc_container/ioc_container.dart';

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
  void registerBloc() {}

  void registerFeatures() {}
}
