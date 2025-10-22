import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../shared/build_context_extensions.dart';
import '../../../shared/null_extensions.dart';
import '../../blocs/device_discovery/device_discovery_bloc.dart';
import '../../styles/app_sizes.dart';
import '../../styles/text_style_extensions.dart';

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
              context.appLocalizations.discoveredDevices(state.devices.length),
              style: context.text.lead,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  IconData _stateToIcon(DeviceDiscoveryState state) {
    return switch (state) {
      DeviceDiscoverySearching() => LucideIcons.wifiSync,
      DeviceDiscoveryIdle(:final devices) =>
        devices.isEmpty ? LucideIcons.wifiOff : LucideIcons.wifi,
    };
  }
}
