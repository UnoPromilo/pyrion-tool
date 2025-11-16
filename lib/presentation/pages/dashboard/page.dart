import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/device_info/device_info_cubit.dart';
import '../../blocs/device_session/device_session_bloc.dart';
import '../../blocs/motor/motor_cubit.dart';
import '../../styles/app_sizes.dart';
import '../../widgets/app_page.dart';
import '../../widgets/three_section_layout.dart';
import 'widgets/controller.dart';
import 'widgets/device_info.dart';
import 'widgets/disconnect_button.dart';
import 'widgets/motor_control.dart';
import 'widgets/settings.dart';
import 'widgets/statistics.dart';

@immutable
@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: _createDeviceInfoCubit),
        BlocProvider(create: _createMotorCubit),
      ],
      child: const AppPage(
        controller: DashboardPageController(),
        body: ThreeSectionLayout(
          header: _Header(),
          sidebar: _Sidebar(),
          content: _Content(),
        ),
      ),
    );
  }

  DeviceInfoCubit _createDeviceInfoCubit(BuildContext context) {
    final sessionState = context.read<DeviceSessionBloc>().state;
    if (sessionState is! Connected) {
      throw Exception('DeviceInfoCubit initialized without a connected device');
    }
    return DeviceInfoCubit(sessionState.deviceData);
  }

  MotorCubit _createMotorCubit(BuildContext context) {
    // TODO initialize from DeviceSessionBloc
    return MotorCubit();
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(children: [DeviceInfo(), Spacer(), DisconnectButton()]),
        SizedBox(height: AppSizes.spacingSmall),
        Statistics(),
      ],
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 230, child: MotorControl());
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Settings();
  }
}
