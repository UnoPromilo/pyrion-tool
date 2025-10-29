import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../../blocs/device_info/device_info_cubit.dart';
import '../../../blocs/device_session/device_session_bloc.dart';

class DashboardPageController extends SingleChildStatelessWidget {
  const DashboardPageController({super.key});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BlocListener<DeviceSessionBloc, DeviceSessionState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType || current is Connected,
      listener: _onNewState,
      child: child,
    );
  }

  void _onNewState(BuildContext context, DeviceSessionState state) {
    switch (state) {
      case NotConnected():
        context.maybePop();
      case Connecting():
        break;
      case Connected(:final telemetryData):
        context.read<DeviceInfoCubit>().updateTelemetry(telemetryData);
    }
  }
}
