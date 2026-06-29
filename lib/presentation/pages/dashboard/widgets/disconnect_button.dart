import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../shared/build_context_extensions.dart';
import '../../../blocs/device_session/device_session_bloc.dart';
import '../../../widgets/glass_button.dart';

class DisconnectButton extends StatelessWidget {
  const DisconnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassButton.variant(
      variant: GlassButtonVariant.white,
      onPressed: () =>
          context.read<DeviceSessionBloc>().add(const DisconnectDevice()),
      size: ShadButtonSize.sm,
      leading: const Icon(LucideIcons.logOut),
      child: Text(context.appLocalizations.disconnectButton),
    );
  }
}
