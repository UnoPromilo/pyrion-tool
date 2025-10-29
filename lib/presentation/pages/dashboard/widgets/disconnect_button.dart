import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../shared/build_context_extensions.dart';
import '../../../../shared/origin.dart';
import '../../../blocs/device_session/device_session_bloc.dart';

class DisconnectButton extends StatelessWidget {
  const DisconnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadButton.outline(
      onPressed: () => context.read<DeviceSessionBloc>().add(
        const DisconnectDevice(Origin.local),
      ),
      size: ShadButtonSize.sm,
      leading: const Icon(LucideIcons.logOut),
      child: Text(context.appLocalizations.disconnectButton),
    );
  }
}
