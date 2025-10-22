import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../shared/build_context_extensions.dart';
import '../../blocs/device_discovery/device_discovery_bloc.dart';
import '../../styles/app_sizes.dart';
import '../../styles/text_style_extensions.dart';
import 'manual_connect_dialog.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.appLocalizations.appTitle, style: context.text.h3),
            const SizedBox(height: AppSizes.spacingSmall),
            Text(
              context.appLocalizations.selectMotorController,
              style: context.text.list.copyWith(
                color: context.appTheme.grayTextColor,
              ),
            ),
          ],
        ),
        const Spacer(),
        ShadButton(
          child: Row(
            children: [
              const Icon(LucideIcons.plus),
              const SizedBox(width: AppSizes.spacingSmall),
              Text(context.appLocalizations.manualConnection),
            ],
          ),
          onPressed: () => {
            showShadDialog(
              context: context,
              builder: (context) => const ManualConnectDialog(),
            ),
          },
        ),
        const SizedBox(width: AppSizes.spacingLarge),
        ShadButton.secondary(
          child: Row(
            children: [
              const Icon(LucideIcons.refreshCcw),
              const SizedBox(width: AppSizes.spacingSmall),
              Text(context.appLocalizations.refreshDevices),
            ],
          ),
          onPressed: () =>
              context.read<DeviceDiscoveryBloc>().add(RefreshDevices()),
        ),
      ],
    );
  }
}
