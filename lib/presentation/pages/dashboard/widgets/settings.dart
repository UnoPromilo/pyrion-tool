import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../styles/app_sizes.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadCard(
      child: Padding(
        padding: AppSizes.paddingCardSmall,
        child: SizedBox(height: 200),
      ),
    );
  }
}
