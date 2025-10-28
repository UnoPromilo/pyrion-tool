import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Pyrion ESC Tool'**
  String get appTitle;

  /// No description provided for @selectMotorController.
  ///
  /// In en, this message translates to:
  /// **'Select your motor controller'**
  String get selectMotorController;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @noDevicesDiscovered.
  ///
  /// In en, this message translates to:
  /// **'No devices have been found'**
  String get noDevicesDiscovered;

  /// No description provided for @discoveredDevices.
  ///
  /// In en, this message translates to:
  /// **'Discovered Devices ({count})'**
  String discoveredDevices(int count);

  /// No description provided for @deviceDiscoveryErrorNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Network connection failed'**
  String get deviceDiscoveryErrorNetworkError;

  /// No description provided for @deviceDiscoveryErrorAborted.
  ///
  /// In en, this message translates to:
  /// **'Discovery was aborted'**
  String get deviceDiscoveryErrorAborted;

  /// No description provided for @deviceDiscoveryErrorUnauthenticated.
  ///
  /// In en, this message translates to:
  /// **'Authentication required'**
  String get deviceDiscoveryErrorUnauthenticated;

  /// No description provided for @deviceDiscoveryErrorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Discovery service unavailable'**
  String get deviceDiscoveryErrorUnavailable;

  /// No description provided for @deviceDiscoveryErrorInternalError.
  ///
  /// In en, this message translates to:
  /// **'Internal error occurred'**
  String get deviceDiscoveryErrorInternalError;

  /// No description provided for @deviceDiscoveryErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get deviceDiscoveryErrorUnknown;

  /// No description provided for @manualConnectionButton.
  ///
  /// In en, this message translates to:
  /// **'Manual connection'**
  String get manualConnectionButton;

  /// No description provided for @refreshDevices.
  ///
  /// In en, this message translates to:
  /// **'Refresh devices'**
  String get refreshDevices;

  /// No description provided for @index.
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get index;

  /// No description provided for @interface.
  ///
  /// In en, this message translates to:
  /// **'Interface'**
  String get interface;

  /// No description provided for @portAddress.
  ///
  /// In en, this message translates to:
  /// **'Port/Address'**
  String get portAddress;

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get deviceName;

  /// No description provided for @firmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get firmware;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @connectionTypeSerial.
  ///
  /// In en, this message translates to:
  /// **'Serial'**
  String get connectionTypeSerial;

  /// No description provided for @connectionTypeUsb.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get connectionTypeUsb;

  /// No description provided for @connectionTypeCan.
  ///
  /// In en, this message translates to:
  /// **'CAN'**
  String get connectionTypeCan;

  /// No description provided for @connectionTypeVirtual.
  ///
  /// In en, this message translates to:
  /// **'Virtual'**
  String get connectionTypeVirtual;

  /// No description provided for @pleaseSelectOne.
  ///
  /// In en, this message translates to:
  /// **'Please select one'**
  String get pleaseSelectOne;

  /// No description provided for @addressOfDevice.
  ///
  /// In en, this message translates to:
  /// **'Address of the device'**
  String get addressOfDevice;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get connectionFailed;

  /// No description provided for @failedToConnect.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to the device.'**
  String get failedToConnect;

  /// No description provided for @failedToConnectNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Please check the internet connection and try again.'**
  String get failedToConnectNetworkError;

  /// No description provided for @failedToConnectUnauthenticated.
  ///
  /// In en, this message translates to:
  /// **'Please verify that you are authenticated.'**
  String get failedToConnectUnauthenticated;

  /// No description provided for @failedToConnectUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Please verify the connection details and try again.'**
  String get failedToConnectUnavailable;

  /// No description provided for @failedToConnectDeviceNotResponding.
  ///
  /// In en, this message translates to:
  /// **'Please restart the device and try again.'**
  String get failedToConnectDeviceNotResponding;

  /// No description provided for @connectedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Connected successfully'**
  String get connectedSuccessfully;

  /// No description provided for @manualConnectionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual connection'**
  String get manualConnectionDialogTitle;

  /// No description provided for @manualConnectionDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'Please provide details of the device you want to connect to'**
  String get manualConnectionDialogDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
