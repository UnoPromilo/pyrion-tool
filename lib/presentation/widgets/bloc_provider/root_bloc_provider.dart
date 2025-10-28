import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:provider/provider.dart' show MultiProvider;

import '../../blocs/device_session/device_session_bloc.dart';
import 'auto_bloc_provider.dart';

@immutable
final class RootBlocProvider extends MultiProvider {
  RootBlocProvider({
    required super.child,
    required IocContainer container,
    super.key,
  }) : super(
         providers: [
           RepositoryProvider(create: (_) => container),
           const AutoBlocProvider<DeviceSessionBloc>(),
         ],
       );
}
