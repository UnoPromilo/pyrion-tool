import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../shared/build_context_extensions.dart';
import '../../../../blocs/motor/motor_cubit.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotorCubit, MotorState>(
      builder: (context, state) {
        return ShadButton(
          enabled: state is! MotorPoweredOff,
          child: Text(context.appLocalizations.motorControlApplyButton),
        );
      },
    );
  }
}
