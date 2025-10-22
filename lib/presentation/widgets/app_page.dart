import 'package:flutter/material.dart';

import '../styles/app_theme.dart';

class AppPage extends StatelessWidget {
  const AppPage({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: theme.backgroundGradient),
        child: body,
      ),
    );
  }
}
