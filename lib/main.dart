import 'package:flutter/widgets.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'dependencies.dart';
import 'l10n/app_localizations.dart';
import 'logging.dart';
import 'presentation/styles/app_theme.dart';
import 'presentation/styles/default_theme.dart';
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
    return ShadApp.router(
      title: 'BLDC Tool',
      theme: defaultShadThemeData,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: widget.router.config(),
      builder: (_, child) {
        return AppTheme(
          data: defaultAppThemeData,
          child: RootBlocProvider(container: widget.container, child: child),
        );
      },
    );
  }
}
