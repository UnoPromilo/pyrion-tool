import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../styles/app_sizes.dart';
import '../styles/app_theme.dart';

class AppPage extends StatelessWidget {
  const AppPage({required this.body, this.controller, super.key});

  final Widget body;
  final SingleChildWidget? controller;

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      return MultiProvider(providers: [controller!], child: _Scaffold(body));
    }
    return _Scaffold(body);
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold(this.body);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: theme.backgroundGradient),
        child: Padding(padding: AppSizes.paddingPage, child: body),
      ),
    );
  }
}
