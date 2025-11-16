// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pyrion ESC Tool';

  @override
  String get selectMotorController => 'Select your motor controller';

  @override
  String get searching => 'Searching...';

  @override
  String get noDevicesDiscovered => 'No devices have been found';

  @override
  String discoveredDevices(int count) {
    return 'Discovered Devices ($count)';
  }

  @override
  String get deviceDiscoveryErrorNetworkError => 'Network connection failed';

  @override
  String get deviceDiscoveryErrorAborted => 'Discovery was aborted';

  @override
  String get deviceDiscoveryErrorUnauthenticated => 'Authentication required';

  @override
  String get deviceDiscoveryErrorUnavailable => 'Discovery service unavailable';

  @override
  String get deviceDiscoveryErrorInternalError => 'Internal error occurred';

  @override
  String get deviceDiscoveryErrorUnknown => 'Unknown error';

  @override
  String get manualConnectionButton => 'Manual connection';

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
  String get connectionTypeVirtual => 'Virtual';

  @override
  String get pleaseSelectOne => 'Please select one';

  @override
  String get addressOfDevice => 'Address of the device';

  @override
  String get connectionFailed => 'Connection failed';

  @override
  String get failedToConnect => 'Failed to connect to the device.';

  @override
  String get failedToConnectNetworkError =>
      'Please check the internet connection and try again.';

  @override
  String get failedToConnectUnauthenticated =>
      'Please verify that you are authenticated.';

  @override
  String get failedToConnectUnavailable =>
      'Please verify the connection details and try again.';

  @override
  String get failedToConnectDeviceNotResponding =>
      'Please restart the device and try again.';

  @override
  String get failedToConnectConnectionLost =>
      'Connection to the device was lost.';

  @override
  String get connectedSuccessfully => 'Connected successfully';

  @override
  String get manualConnectionDialogTitle => 'Manual connection';

  @override
  String get manualConnectionDialogDescription =>
      'Please provide details of the device you want to connect to';

  @override
  String get disconnectButton => 'Disconnect';

  @override
  String get statisticsMotorTemp => 'Motor';

  @override
  String get statisticsCpuTemp => 'CPU';

  @override
  String get statisticsDriverTemp => 'MOSFETs';

  @override
  String get statisticsVBus => 'V-Bus';

  @override
  String get statisticsPower => 'Power';

  @override
  String get statisticsCurrent => 'Current';

  @override
  String get statisticsDutyCycle => 'Duty';

  @override
  String get motorStateTitle => 'Motor State';

  @override
  String get motorStateOn => 'Motor ON';

  @override
  String get motorStateOff => 'Motor OFF';

  @override
  String get motorControlMode => 'Control Mode';

  @override
  String get modeControlDuty => 'Duty';

  @override
  String get modeControlVelocity => 'Velocity';

  @override
  String get modeControlTorque => 'Torque';

  @override
  String get modeControlPosition => 'Position';

  @override
  String get motorControlTarget => 'Target';

  @override
  String get motorControlApplyButton => 'Apply';

  @override
  String get motorControlInfoTarget => 'Target';

  @override
  String get motorControlInfoActual => 'Actual';
}
