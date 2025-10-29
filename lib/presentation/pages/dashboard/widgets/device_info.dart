import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/app_localizations_extensions.dart';
import '../../../../shared/build_context_extensions.dart';
import '../../../blocs/device_info/device_info_cubit.dart';
import '../../../styles/style_extensions.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        const SizedBox(width: 5),
        const _MotorStateIndicator(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _DeviceName(),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 12,
                color: context.appTheme.grayTextColor,
              ),
              child: const Row(
                spacing: 5,
                children: [
                  _Interface(),
                  _DotSeparator(),
                  _FirmwareVersion(),
                  _DotSeparator(),
                  _DeviceId(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DeviceName extends StatelessWidget {
  const _DeviceName();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
      builder: (context, state) {
        return Text(state.deviceData.deviceName);
      },
    );
  }
}

class _Interface extends StatelessWidget {
  const _Interface();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
      builder: (context, state) {
        return Text(
          context.appLocalizations.interfaceToString(
            state.deviceData.interface,
          ),
        );
      },
    );
  }
}

class _DeviceId extends StatelessWidget {
  const _DeviceId();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
      builder: (context, state) {
        return Text(state.deviceData.deviceId);
      },
    );
  }
}

class _FirmwareVersion extends StatelessWidget {
  const _FirmwareVersion();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
      builder: (context, state) {
        return Text(state.deviceData.firmwareVersion);
      },
    );
  }
}

class _MotorStateIndicator extends StatelessWidget {
  const _MotorStateIndicator();

  @override
  Widget build(BuildContext context) {
    // TODO implement color change based on MotorState
    final theme = context.appTheme.motorStateIndicator;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.powered,
        borderRadius: BorderRadius.circular(99),
      ),
      child: const SizedBox(width: 10, height: 10),
    );
  }
}

class _DotSeparator extends StatelessWidget {
  const _DotSeparator();

  @override
  Widget build(BuildContext context) {
    return const Text('•');
  }
}

class MotorStateIndicatorTheme {
  MotorStateIndicatorTheme({required this.powered, required this.idle});

  final Color powered;
  final Color idle;
}
