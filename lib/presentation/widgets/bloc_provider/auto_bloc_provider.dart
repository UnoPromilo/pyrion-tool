import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../shared/build_context_extensions.dart';

@immutable
class AutoBlocProvider<T extends StateStreamableSource<Object?>>
    extends SingleChildStatelessWidget {
  const AutoBlocProvider({this.isLazy = true, super.key})
    : builder = null,
      super(child: null);

  const AutoBlocProvider.withChild({
    required Widget super.child,
    this.isLazy = true,
    super.key,
  }) : builder = null;

  const AutoBlocProvider.withBuild({
    required WidgetBuilder this.builder,
    this.isLazy = true,
    super.key,
  }) : super(child: null);

  final bool isLazy;
  final WidgetBuilder? builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return InheritedProvider<T>(
      create: createBloc,
      dispose: (_, bloc) => bloc.close(),
      startListening: _startListening,
      lazy: isLazy,
      child: builder != null ? Builder(builder: builder!) : child,
    );
  }

  @protected
  T createBloc(BuildContext context) => context.fromContainer<T>();

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
