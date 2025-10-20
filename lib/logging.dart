import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void initializeLogging() {
  final logHandler = ConsoleLogHandler();
  _initializeLogger(logHandler);
  _initializeFlutterErrorLogging(logHandler);
  _initializePlatformDispatcherErrorLogging(logHandler);
}

void _initializeLogger(LogHandler logHandler) {
  Logger.root
    ..level = Level.ALL
    ..onRecord.listen(logHandler.onLog);
}

void _initializeFlutterErrorLogging(LogHandler logHandler) {
  FlutterError.onError = (details) {
    if (details.silent) {
      return;
    }

    logHandler.onLog(
      LogRecord(
        Level.WARNING,
        details.summary.toString(),
        'FlutterError',
        details.exception,
        details.stack,
      ),
    );
  };
}

void _initializePlatformDispatcherErrorLogging(LogHandler logHandler) {
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logHandler.onLog(
      LogRecord(
        Level.SHOUT,
        'UnhandledError',
        'PlatformDispatcher',
        error,
        stackTrace,
      ),
    );

    return true;
  };
}

abstract class LogHandler {
  void onLog(LogRecord record);
}

abstract class BaseLogHandler implements LogHandler {
  @protected
  bool shouldLog(LogRecord record);

  @protected
  void log(LogRecord record);

  @override
  void onLog(LogRecord record) {
    if (shouldLog(record)) {
      log(record);
    }
  }
}

@immutable
final class ConsoleLogHandler extends BaseLogHandler {
  @override
  bool shouldLog(LogRecord record) => true;

  @override
  void log(LogRecord record) {
    debugPrint(
      '[${DateTime.now().toUtc().toIso8601String()}] [${record.level.name}] ${record.loggerName}: ${record.message}',
    );

    if (record.error != null && record.stackTrace != null) {
      debugPrintStack(
        stackTrace: record.stackTrace,
        label: record.error.toString(),
      );
    } else if (record.error != null) {
      debugPrint(record.error.toString());
    } else if (record.stackTrace != null) {
      debugPrintStack(stackTrace: record.stackTrace);
    }
  }
}
