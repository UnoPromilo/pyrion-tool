import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/device_info/device_info_cubit.dart';
import '../../blocs/device_session/device_session_bloc.dart';
import '../../styles/app_sizes.dart';
import '../../widgets/app_page.dart';
import 'widgets/controller.dart';
import 'widgets/device_info.dart';
import 'widgets/disconnect_button.dart';

@immutable
@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: _createCubit,
      child: const AppPage(
        controller: DashboardPageController(),
        body: Padding(
          padding: EdgeInsetsGeometry.all(AppSizes.paddingPage),
          child: Column(
            children: [
              Row(children: [DeviceInfo(), Spacer(), DisconnectButton()]),
            ],
          ),
        ),
      ),
    );
  }

  DeviceInfoCubit _createCubit(BuildContext context) {
    final sessionState = context.read<DeviceSessionBloc>().state;
    if (sessionState is! Connected) {
      throw Exception('DeviceInfoCubit initialized without a connected device');
    }
    return DeviceInfoCubit(sessionState.deviceData);
  }
}
