// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ferro BLDC Toolbox';

  @override
  String get selectMotorController => 'Select your motor controller';

  @override
  String discoveredDevices(int count) {
    return 'Discovered Devices ($count)';
  }

  @override
  String get manualConnection => 'Manual connection';

  @override
  String get refreshDevices => 'Refresh devices';

  @override
  String get index => 'Index';

  @override
  String get interface => 'Interface';

  @override
  String get portAddress => 'Port/Address';

  @override
  String get deviceName => 'Device name';

  @override
  String get firmware => 'Firmware';

  @override
  String get action => 'Action';

  @override
  String get connect => 'Connect';

  @override
  String get connectionTypeSerial => 'Serial';

  @override
  String get connectionTypeUsb => 'USB';

  @override
  String get connectionTypeCan => 'CAN';

  @override
  String get pleaseSelectOne => 'Please select one';

  @override
  String get addressOfDevice => 'Address of the device';
}
