import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioc_container/ioc_container.dart';

import '../l10n/app_localizations.dart';

extension IocExtensions on BuildContext {
  IocContainer get iocContainer => RepositoryProvider.of<IocContainer>(this);

  AppLocalizations get appLocalizations => AppLocalizations.of(this)!;

  T fromContainer<T extends Object>() => iocContainer<T>();
}
