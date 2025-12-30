import 'package:flutter/widgets.dart';
import '../awesome_logger.dart';

extension LoggerContext on BuildContext {
  AwesomeLoggerInstance get log => AwesomeLoggerInstance(this);
}

class AwesomeLoggerInstance {
  final BuildContext context;

  AwesomeLoggerInstance(this.context);

  String? get _widgetName {
    try {
      return context.widget.runtimeType.toString();
    } catch (e) {
      return null;
    }
  }

  void success(String message) {
    AwesomeLogger.success(message, name: _widgetName);
  }

  void error(String message, {dynamic error, StackTrace? stackTrace}) {
    AwesomeLogger.error(
      message,
      name: _widgetName,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void warning(String message) {
    AwesomeLogger.warning(message, name: _widgetName);
  }

  void info(String message) {
    AwesomeLogger.info(message, name: _widgetName);
  }

  void debug(String message) {
    AwesomeLogger.debug(message, name: _widgetName);
  }

  void verbose(String message) {
    AwesomeLogger.verbose(message, name: _widgetName);
  }

  void network(String message) {
    AwesomeLogger.network(message, name: _widgetName);
  }

  void database(String message) {
    AwesomeLogger.database(message, name: _widgetName);
  }

  void auth(String message) {
    AwesomeLogger.auth(message, name: _widgetName);
  }

  void navigation(String message) {
    AwesomeLogger.navigation(message, name: _widgetName);
  }

  void ui(String message) {
    AwesomeLogger.ui(message, name: _widgetName);
  }

  void payment(String message) {
    AwesomeLogger.payment(message, name: _widgetName);
  }

  void chat(String message) {
    AwesomeLogger.chat(message, name: _widgetName);
  }

  void firebase(String message) {
    AwesomeLogger.firebase(message, name: _widgetName);
  }

  void api(String message) {
    AwesomeLogger.api(message, name: _widgetName);
  }

  void file(String message) {
    AwesomeLogger.file(message, name: _widgetName);
  }

  void notification(String message) {
    AwesomeLogger.notification(message, name: _widgetName);
  }

  void performance(String message) {
    AwesomeLogger.performance(message, name: _widgetName);
  }

  void analytics(String message) {
    AwesomeLogger.analytics(message, name: _widgetName);
  }

  void security(String message) {
    AwesomeLogger.security(message, name: _widgetName);
  }

  void httpStatus(int statusCode, String endpoint, {String? method}) {
    AwesomeLogger.httpStatus(statusCode, endpoint, method: method);
  }

  void httpBody(String body, {String type = 'BODY'}) {
    AwesomeLogger.httpBody(body, type: type);
  }

  void json(dynamic jsonData, {String? description}) {
    AwesomeLogger.json(jsonData, description: description);
  }

  void userAction(String action, {Map<String, dynamic>? context}) {
    AwesomeLogger.userAction(action, context: context);
  }

  void stateChange(String from, String to) {
    AwesomeLogger.stateChange(from, to, component: _widgetName);
  }

  void lifecycle(String event) {
    AwesomeLogger.lifecycle(event, widget: _widgetName);
  }

  void startTimer(String timerName) {
    AwesomeLogger.startTimer('$_widgetName.$timerName');
  }

  Duration? stopTimer(String timerName) {
    return AwesomeLogger.stopTimer('$_widgetName.$timerName');
  }

  Map<String, dynamic>? getTimerStats(String timerName) {
    return AwesomeLogger.getTimerStats('$_widgetName.$timerName');
  }
}

extension TimerExtension on AwesomeLoggerInstance {
  Future<T> measure<T>(String name, Future<T> Function() function) async {
    startTimer(name);
    try {
      final result = await function();
      stopTimer(name);
      return result;
    } catch (e, stack) {
      stopTimer(name);
      error('Failed during $name', error: e, stackTrace: stack);
      rethrow;
    }
  }

  T measureSync<T>(String name, T Function() function) {
    startTimer(name);
    try {
      final result = function();
      stopTimer(name);
      return result;
    } catch (e, stack) {
      stopTimer(name);
      error('Failed during $name', error: e, stackTrace: stack);
      rethrow;
    }
  }
}