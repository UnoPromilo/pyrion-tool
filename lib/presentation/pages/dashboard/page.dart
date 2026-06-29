import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/device_info/device_info_cubit.dart';
import '../../blocs/motor/motor_cubit.dart';
import '../../styles/app_sizes.dart';
import '../../widgets/app_page.dart';
import '../../widgets/bloc_provider/session_aware_bloc_provider.dart';
import '../../widgets/three_section_layout.dart';
import 'widgets/controller.dart';
import 'widgets/device_info.dart';
import 'widgets/disconnect_button.dart';
import 'widgets/faults_button.dart';
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
        SessionAwareBlocProvider(
          create: (_, session) => DeviceInfoCubit(session),
        ),
        SessionAwareBlocProvider(create: (_, session) => MotorCubit(/*TODO*/)),
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
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: DeviceInfo()),
            SizedBox(width: AppSizes.spacingLarge),
            FaultsButton(),
            SizedBox(width: AppSizes.spacingSmall),
            DisconnectButton(),
          ],
        ),
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
