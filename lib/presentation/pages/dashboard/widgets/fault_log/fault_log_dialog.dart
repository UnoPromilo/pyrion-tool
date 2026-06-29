import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../features/device_session/device_event.dart';
import '../../../../../shared/build_context_extensions.dart';
import '../../../../blocs/fault_register/fault_register_cubit.dart';
import '../../../../styles/app_sizes.dart';
import '../../../../styles/style_extensions.dart';
import '../../../../widgets/bloc_provider/session_aware_bloc_provider.dart';

class FaultsLogDialog extends StatelessWidget {
  const FaultsLogDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SessionAwareBlocProvider(
      create: (_, session) => FaultRegisterCubit(session),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingXLarge),
        child: ShadDialog(
          title: Text(context.appLocalizations.faultLog),
          constraints: const BoxConstraints(minWidth: 450, maxWidth: 450),
          actionsMainAxisSize: MainAxisSize.max,
          actionsMainAxisAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            _ClearResolvedFaultsButton(),
            ShadButton.outline(
              onPressed: context.pop,
              child: Text(context.appLocalizations.closeButton),
            ),
          ],
          child: _Content(),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300),
      child: BlocBuilder<FaultRegisterCubit, FaultRegisterState>(
        builder: (context, state) {
          if (state.errors.isEmpty) {
            return _NoFaults();
          }

          return Padding(
            padding: const EdgeInsets.only(top: AppSizes.spacingLarge),
            child: Column(
              spacing: AppSizes.spacingMedium,
              children: state.errors.map(_FaultCard.new).toList(),
            ),
          );
        },
      ),
    );
  }
}

class _NoFaults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.checkCircle2,
            size: AppSizes.defaultAppIconSize,
            color: context.appTheme.faultLogTheme.noFaultsIconColor,
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Text(
            context.appLocalizations.noFaultsRecorded,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ClearResolvedFaultsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaultRegisterCubit, FaultRegisterState>(
      builder: (context, state) {
        return ShadButton.outline(
          enabled: state.resolved.isNotEmpty,
          leading: const Icon(LucideIcons.trash2),
          onPressed: context.read<FaultRegisterCubit>().clearResolved,
          child: Row(children: [Text(context.appLocalizations.clearLatched)]),
        );
      },
    );
  }
}

class _FaultCard extends StatelessWidget {
  const _FaultCard(this.fault);

  final FaultEntry fault;

  @override
  Widget build(BuildContext context) {
    final icon = switch (fault.state) {
      FaultState.ongoing => LucideIcons.alertCircle,
      FaultState.latched => LucideIcons.alertTriangle,
    };

    final color = switch (fault.state) {
      FaultState.ongoing => context.appTheme.faultLogTheme.activeFaultColor,
      FaultState.latched => context.appTheme.faultLogTheme.latchedFaultColor,
    };

    final badge = switch (fault.state) {
      FaultState.ongoing => context.appLocalizations.activeFaultBadge,
      FaultState.latched => context.appLocalizations.latchedFaultBadge,
    };

    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSizes.spacingMedium,
            children: [
              Icon(icon, size: AppSizes.smallIconSize, color: color),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppSizes.spacingMedium,
                children: [
                  Text(
                    _getFaultTitle(context, fault.type),
                    style: context.text.p.copyWith(
                      color: context.appTheme.mainTextColor,
                    ),
                  ),
                  ShadBadge(backgroundColor: color, child: Text(badge)),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spacingSmall),

          Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.smallIconSize + AppSizes.spacingMedium,
            ),
            child: Text(_getFaultDescription(context, fault.type)),
          ),
        ],
      ),
    );
  }

  String _getFaultTitle(BuildContext context, FaultType type) {
    return switch (type) {
      FaultType.encoder => context.appLocalizations.encoderFaultHeader,
    };
  }

  String _getFaultDescription(BuildContext context, FaultType type) {
    return switch (type) {
      FaultType.encoder => context.appLocalizations.encoderFaultDescription,
    };
  }
}

class FaultLogTheme {
  const FaultLogTheme({
    required this.activeFaultColor,
    required this.latchedFaultColor,
    required this.noFaultsIconColor,
  });

  final Color noFaultsIconColor;
  final Color activeFaultColor;
  final Color latchedFaultColor;
}
