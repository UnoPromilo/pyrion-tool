import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../features/device_session/device_session_service.dart';
import '../../../../shared/build_context_extensions.dart';
import '../../../blocs/device_session/device_session_bloc.dart';
import '../../../styles/app_sizes.dart';
import '../../../styles/style_extensions.dart';
import '../../../widgets/status_icon/app_error_icon.dart';
import '../../../widgets/status_icon/app_success_icon.dart';

class ConnectingDialog extends StatelessWidget {
  const ConnectingDialog({required this.deviceName, super.key});

  final String? deviceName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceSessionBloc, DeviceSessionState>(
      builder: (context, state) {
        return ShadDialog(
          closeIcon: const SizedBox.shrink(),
          actions: [
            if (state is NotConnected)
              ShadButton.secondary(
                child: const Text('Back to devices'),
                onPressed: () => context.pop(),
              ),
          ],
          actionsMainAxisAlignment: MainAxisAlignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.spacingLarge,
            ),
            child: switch (state) {
              NotConnected(:final error) when error != null => _ConnectionError(
                deviceName: deviceName,
                error: error,
              ),
              NotConnected() => _ConnectionError(
                deviceName: deviceName,
                error: ConnectionError.unavailable,
              ),
              Connecting() => _Connecting(deviceName: deviceName),
              Connected() => _Redirecting(deviceName: deviceName),
            },
          ),
        );
      },
    );
  }
}

class _Connecting extends StatelessWidget {
  const _Connecting({required this.deviceName});

  final String? deviceName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpinKitDoubleBounce(color: context.appTheme.spinnerColor),
        const SizedBox(height: 20),
        Text('Connecting...', style: context.shadTheme.textTheme.h3),
        if (deviceName != null)
          Text(deviceName!)
        else
          const Text('Waiting for device response'),
      ],
    );
  }
}

class _ConnectionError extends StatelessWidget {
  const _ConnectionError({required this.deviceName, required this.error});

  final ConnectionError error;
  final String? deviceName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppErrorIcon(),
        const SizedBox(height: 20),
        Text(context.appLocalizations.connectionFailed, style: context.text.h3),
        if (deviceName != null) Text(deviceName!) else const Text(':/'),
        const SizedBox(height: 20),
        ShadAlert.destructive(
          mainAxisAlignment: MainAxisAlignment.center,
          description: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${context.appLocalizations.failedToConnect}}\n${_errorToString(context, error)}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _errorToString(BuildContext context, ConnectionError error) {
    return switch (error) {
      ConnectionError.networkError =>
        context.appLocalizations.failedToConnectNetworkError,
      ConnectionError.unauthenticated =>
        context.appLocalizations.failedToConnectUnauthenticated,
      ConnectionError.unavailable =>
        context.appLocalizations.failedToConnectUnavailable,
      ConnectionError.deviceNotResponding =>
        context.appLocalizations.failedToConnectDeviceNotResponding,
    };
  }
}

class _Redirecting extends StatelessWidget {
  const _Redirecting({required this.deviceName});

  final String? deviceName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppSuccessIcon(),
        const SizedBox(height: 20),
        Text(
          context.appLocalizations.connectedSuccessfully,
          style: context.shadTheme.textTheme.h3,
        ),
        if (deviceName != null) Text(deviceName!) else const Text(':)'),
      ],
    );
  }
}
