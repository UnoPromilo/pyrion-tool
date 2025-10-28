import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../router.dart';
import '../../../blocs/device_session/device_session_bloc.dart';
import 'connecting_dialog.dart';

class SelectDevicePageController extends SingleChildStatelessWidget {
  const SelectDevicePageController({super.key});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BlocListener<DeviceSessionBloc, DeviceSessionState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: _onNewState,
      child: child,
    );
  }

  void _onNewState(BuildContext context, DeviceSessionState state) {
    switch (state) {
      case NotConnected():
        break;
      case Connecting(:final deviceName):
        showShadDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => ConnectingDialog(deviceName: deviceName),
        );
      case Connected():
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          if (context.mounted) {
            context.pushRoute(const DashboardRoute());
          }
        });
        break;
    }
  }
}
