import 'package:flutter/material.dart';
import 'package:ioc_container/ioc_container.dart';

import 'dependencies.dart';
import 'l10n/app_localizations.dart';
import 'logging.dart';
import 'presentation/widgets/bloc_provider/root_bloc_provider.dart';
import 'router.dart';

void main() {
  initializeLogging();
  runApp(AppRoot(router: AppRouter(), container: createIocContainer()));
}

final class AppRoot extends StatefulWidget {
  const AppRoot({required this.router, required this.container, super.key});

  final AppRouter router;
  final IocContainer container;

  @override
  State<StatefulWidget> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BLDC Tool',
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: widget.router.config(),
      builder: (_, child) {
        return RootBlocProvider(container: widget.container, child: child);
      },
    );
  }
}
