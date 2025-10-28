import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../styles/app_sizes.dart';
import '../../widgets/app_page.dart';

@immutable
@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPage(
      body: Padding(
        padding: EdgeInsetsGeometry.all(AppSizes.paddingPage),
        child: Column(children: [Row(children: [])]),
      ),
    );
  }
}
