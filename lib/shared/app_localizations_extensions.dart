import '../l10n/app_localizations.dart';
import 'interface.dart';

extension AppLocalizationsExtensions on AppLocalizations {
  String interfaceToString(Interface interface) {
    return switch (interface) {
      Interface.serial => connectionTypeSerial,
      Interface.usb => connectionTypeUsb,
      Interface.can => connectionTypeCan,
      Interface.virtual => connectionTypeVirtual,
    };
  }
}
