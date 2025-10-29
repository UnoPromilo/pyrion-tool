import 'package:flutter/material.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:window_manager/window_manager.dart';

import 'dependencies.dart';
import 'l10n/app_localizations.dart';
import 'logging.dart';
import 'presentation/styles/app_theme.dart';
import 'presentation/styles/default_theme.dart';
import 'presentation/widgets/bloc_provider/root_bloc_provider.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeLogging();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    title: 'Pyrion ESC Tool',
    minimumSize: Size(800, 600),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

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
      title: 'Pyrion ESC Tool',
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
