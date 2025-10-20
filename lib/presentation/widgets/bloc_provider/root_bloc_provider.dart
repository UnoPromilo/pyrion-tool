import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:provider/provider.dart' show MultiProvider;

@immutable
final class RootBlocProvider extends MultiProvider {
  RootBlocProvider({
    required super.child,
    required IocContainer container,
    super.key,
  }) : super(providers: [RepositoryProvider(create: (_) => container)]);
}
