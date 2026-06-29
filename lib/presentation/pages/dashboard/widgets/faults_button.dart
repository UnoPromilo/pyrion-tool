import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../shared/build_context_extensions.dart';
import '../../../blocs/device_info/device_info_cubit.dart';
import '../../../widgets/glass_button.dart';
import 'fault_log/fault_log_dialog.dart';

class FaultsButton extends StatelessWidget {
  const FaultsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
      builder: (context, state) {
        final buttonState = _getState(state);
        return GlassButton.variant(
          variant: _getGlassButtonVariant(buttonState),
          size: ShadButtonSize.sm,
          leading: Icon(_getIcon(buttonState)),
          child: Text(_getText(context, buttonState)),
          onPressed: () => {
            showShadDialog(
              context: context,
              builder: (_) => const FaultsLogDialog(),
            ),
          },
        );
      },
    );
  }

  _FaultsButtonState _getState(DeviceInfoState state) {
    if (state.telemetryData.activeFaults > 0) {
      return _FaultsButtonState.ongoingErrors;
    }
    if (state.telemetryData.latchedFaults > 0) {
      return _FaultsButtonState.resolvedErrors;
    }
    return _FaultsButtonState.ok;
  }

  GlassButtonVariant _getGlassButtonVariant(_FaultsButtonState state) {
    return switch (state) {
      _FaultsButtonState.ongoingErrors => GlassButtonVariant.red,
      _FaultsButtonState.resolvedErrors => GlassButtonVariant.yellow,
      _FaultsButtonState.ok => GlassButtonVariant.green,
    };
  }

  IconData _getIcon(_FaultsButtonState state) {
    return switch (state) {
      _FaultsButtonState.ongoingErrors => LucideIcons.messageCircleX,
      _FaultsButtonState.resolvedErrors => LucideIcons.messageCircleWarning,
      _FaultsButtonState.ok => LucideIcons.messageCircleCheck,
    };
  }

  String _getText(BuildContext context, _FaultsButtonState state) {
    return switch (state) {
      _FaultsButtonState.ongoingErrors =>
        context.appLocalizations.activeFaultsButton,
      _FaultsButtonState.resolvedErrors =>
        context.appLocalizations.latchedFaultsButton,
      _FaultsButtonState.ok => context.appLocalizations.noFaultsButton,
    };
  }
}

enum _FaultsButtonState { ongoingErrors, resolvedErrors, ok }
