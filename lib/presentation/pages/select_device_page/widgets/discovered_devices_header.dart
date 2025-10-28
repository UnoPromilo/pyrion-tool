import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../features/device_discovery/device_discovery_service.dart';
import '../../../../shared/build_context_extensions.dart';
import '../../../../shared/null_extensions.dart';
import '../../../blocs/device_discovery/device_discovery_bloc.dart';
import '../../../styles/app_sizes.dart';
import '../../../styles/style_extensions.dart';

class DiscoveredDevicesHeader extends StatelessWidget {
  const DiscoveredDevicesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceDiscoveryBloc, DeviceDiscoveryState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSizes.spacingSmall,
          children: [
            Icon(_stateToIcon(state), size: context.text.lead.fontSize + 2),
            Text(
              _stateToText(context, state),
              style: context.text.lead,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  String _stateToText(BuildContext context, DeviceDiscoveryState state) {
    return switch (state) {
      DeviceDiscoverySearching() => context.appLocalizations.searching,
      DeviceDiscoveryIdle(:final devices) when devices.isEmpty =>
        context.appLocalizations.noDevicesDiscovered,
      DeviceDiscoveryIdle(:final devices) =>
        context.appLocalizations.discoveredDevices(devices.length),
      DeviceDiscoveryError(:final error) => switch (error) {
        DiscoveryError.networkError =>
          context.appLocalizations.deviceDiscoveryErrorNetworkError,
        DiscoveryError.aborted =>
          context.appLocalizations.deviceDiscoveryErrorAborted,
        DiscoveryError.unauthenticated =>
          context.appLocalizations.deviceDiscoveryErrorUnauthenticated,
        DiscoveryError.unavailable =>
          context.appLocalizations.deviceDiscoveryErrorUnavailable,
        DiscoveryError.internalError =>
          context.appLocalizations.deviceDiscoveryErrorInternalError,
        DiscoveryError.unknown =>
          context.appLocalizations.deviceDiscoveryErrorUnknown,
      },
    };
  }

  IconData _stateToIcon(DeviceDiscoveryState state) {
    return switch (state) {
      DeviceDiscoverySearching() => LucideIcons.wifiSync,
      DeviceDiscoveryIdle(:final devices) when devices.isEmpty =>
        LucideIcons.wifiOff,
      DeviceDiscoveryIdle() => LucideIcons.wifi,
      DeviceDiscoveryError() => LucideIcons.wifiOff,
    };
  }
}
