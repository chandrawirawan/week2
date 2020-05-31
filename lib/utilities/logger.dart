import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart' as logprint;

class _SimpleLogPrinter extends logprint.LogPrinter {
  final String className;
  _SimpleLogPrinter(this.className);  

  @override
  void log(logprint.Level level, message, error, StackTrace stackTrace) {
    final color = logprint.PrettyPrinter.levelColors[level];
    final emoji = logprint.PrettyPrinter.levelEmojis[level];
    println(color('$emoji $className - $message'));
  }
}

logprint.Logger getLogger(String className) {
  return logprint.Logger(printer: _SimpleLogPrinter(className));
}

/// Run this before starting app
void configureLogger() {
  Logger.addClient(DebugLoggerClient());
}

void testsLogger() {
  Logger.addClient(DebugLoggerClient());
}

class Logger {
  static final _clients = <LoggerClient>[];

  /// Debug level logs
  static void d(
    String message, {
    dynamic e,
    StackTrace s,
  }) {
    _clients.forEach((c) => c.onLog(
          level: LogLevel.debug,
          message: message,
          e: e,
          s: s,
        ));
  }

  // Warning level logs
  static void w(
    String message, {
    dynamic e,
    StackTrace s,
  }) {
    _clients.forEach((c) => c.onLog(
      level: LogLevel.warning,
      message: message,
      e: e,
      s: s,
    ));
  }

  /// Error level logs
  /// Requires a current StackTrace to report correctly on Crashlytics
  /// Always reports as non-fatal to Crashlytics
  static void e(
    String message, {
    dynamic e,
    @required StackTrace s,
  }) {
    _clients.forEach((c) => c.onLog(
      level: LogLevel.error,
      message: message,
      e: e,
      s: s,
    ));
  }

  static void addClient(LoggerClient client) {
    _clients.add(client);
  }
}

enum LogLevel { debug, warning, error }

abstract class LoggerClient {
  void onLog({
    LogLevel level,
    String message,
    dynamic e,
    StackTrace s,
  });
}

/// Debug logger that just prints to console
class DebugLoggerClient implements LoggerClient {

  String _timestamp() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute}:${now.second}.${now.millisecond}';
  }

  @override
  void onLog({
    LogLevel level,
    String message,
    dynamic e,
    StackTrace s,
  }) {
    switch (level) {
      case LogLevel.debug:
        getLogger('${_timestamp()}').d('[DEBUG]  $message');
        if (e != null) {
          getLogger('[DEBUG]').d(e);
          getLogger('🤪🤪').d(e);
          getLogger('🤪🤪').d(s.toString() ?? StackTrace.current);
        }
        break;
      case LogLevel.warning:
        getLogger('${_timestamp()} ').w('[WARNING]  $message');
        if (e != null) {
          getLogger('😭😭').d('$e.toString()');
          getLogger('😭😭').d(s.toString() ?? StackTrace.current.toString());
        }
        break;
      case LogLevel.error:
        getLogger('${_timestamp()} ').e('[ERROR]  $message');
        if (e != null) {
          getLogger('🤬😡').e(e.toString());
        }
        // Errors always show a StackTrace
        getLogger('🤬😡').e(e);
        break;
    }
  }
}
