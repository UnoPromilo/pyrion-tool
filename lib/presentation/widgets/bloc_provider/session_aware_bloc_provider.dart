import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../features/device_session/device_session.dart';
import '../../blocs/device_session/device_session_bloc.dart';

@immutable
final class SessionAwareBlocProvider<B extends StateStreamableSource<Object?>>
    extends SingleChildStatelessWidget {
  const SessionAwareBlocProvider({
    required this.create,
    this.isLazy = true,
    super.key,
    super.child,
  });

  final B Function(BuildContext context, DeviceSession session) create;
  final bool isLazy;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return InheritedProvider<B>(
      create: (context) {
        final sessionState = context.read<DeviceSessionBloc>().state;
        if (sessionState is! Connected) {
          throw StateError(
            '$B was created without an active device session. '
            'Current DeviceSessionBloc state: ${sessionState.runtimeType}.',
          );
        }
        return create(context, sessionState.session);
      },
      dispose: (_, bloc) => bloc.close(),
      startListening: _startListening,
      lazy: isLazy,
      child: child,
    );
  }

  static VoidCallback _startListening<T>(
    InheritedContext<StateStreamable<T>?> e,
    StateStreamable<T> value,
  ) {
    final subscription = value.stream.listen(
      (_) => e.markNeedsNotifyDependents(),
    );
    return subscription.cancel;
  }
}
