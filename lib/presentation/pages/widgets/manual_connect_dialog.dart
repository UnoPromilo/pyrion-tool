import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../features/device_discovery/discovered_device.dart';
import '../../../shared/build_context_extensions.dart';
import '../../styles/app_sizes.dart';

class ManualConnectDialog extends StatelessWidget {
  const ManualConnectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: const Text('Manual connection'),
      description: const Text(
        'Please provide details of device you want to connect to',
      ),
      actions: [
        ShadButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Connect'),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 12,
          children: [
            Row(
              children: [
                Expanded(child: Text(context.appLocalizations.interface)),
                Expanded(
                  child: ShadSelect<ConnectionType>(
                    placeholder: Text(context.appLocalizations.pleaseSelectOne),
                    options: ConnectionType.values.map(
                      (e) => ShadOption(
                        value: e,
                        child: Text(_connectionTypeToString(e, context)),
                      ),
                    ),
                    selectedOptionBuilder: (context, value) =>
                        Text(_connectionTypeToString(value, context)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(context.appLocalizations.portAddress)),
                Expanded(
                  child: ShadInput(
                    placeholder: Text(context.appLocalizations.addressOfDevice),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _connectionTypeToString(
    ConnectionType connectionType,
    BuildContext context,
  ) {
    return switch (connectionType) {
      ConnectionType.serial => context.appLocalizations.connectionTypeSerial,
      ConnectionType.usb => context.appLocalizations.connectionTypeUsb,
      ConnectionType.can => context.appLocalizations.connectionTypeCan,
    };
  }
}
