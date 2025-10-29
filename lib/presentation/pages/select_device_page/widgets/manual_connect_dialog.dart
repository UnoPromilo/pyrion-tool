import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../shared/app_localizations_extensions.dart';
import '../../../../shared/build_context_extensions.dart';
import '../../../../shared/interface.dart';
import '../../../styles/app_sizes.dart';

class ManualConnectDialog extends StatelessWidget {
  const ManualConnectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      title: Text(context.appLocalizations.manualConnectionDialogTitle),
      description: Text(
        context.appLocalizations.manualConnectionDialogDescription,
      ),
      actions: [
        ShadButton(
          onPressed: Navigator.of(context).pop,
          child: Text(context.appLocalizations.connect),
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
                  child: ShadSelect<Interface>(
                    placeholder: Text(context.appLocalizations.pleaseSelectOne),
                    options: Interface.values.map(
                      (e) => ShadOption(
                        value: e,
                        child: Text(
                          context.appLocalizations.interfaceToString(e),
                        ),
                      ),
                    ),
                    selectedOptionBuilder: (context, value) =>
                        Text(context.appLocalizations.interfaceToString(value)),
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
}
