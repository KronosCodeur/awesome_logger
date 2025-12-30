library awesome_logger;

import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

import 'awesome_logger.dart';

export 'src/logger_extensions.dart';
export 'src/logger_config.dart';

class AwesomeLogger {
  static AwesomeLoggerConfig _config = AwesomeLoggerConfig();

  static void configure(AwesomeLoggerConfig config) {
    _config = config;
  }

  static AwesomeLoggerConfig get config => _config;

  static bool get isEnabled => _config.enabled && (kDebugMode || _config.forceEnable);

  static String _getTimestamp() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}.'
        '${now.millisecond.toString().padLeft(3, '0')}';
  }

  static String _formatMessage(String emoji, String category, String message) {
    if (_config.showTimestamp) {
      return '$emoji [$category] [${_getTimestamp()}] $message';
    }
    return '$emoji [$category] $message';
  }

  static void _log(
      String emoji,
      String category,
      String message, {
        String? name,
        int? level,
      }) {
    if (!isEnabled) return;

    if (_config.disabledCategories.contains(category)) return;

    final formattedMessage = _formatMessage(emoji, category, message);

    developer.log(
      _config.showTimestamp ? message : formattedMessage,
      name: name ?? '$emoji $category',
      time: DateTime.now(),
      level: level ?? 0,
    );
  }

  static void success(String message, {String? name}) {
    _log('✅', 'SUCCESS', message, name: name, level: 800);
  }

  static void error(
      String message, {
        String? name,
        dynamic error,
        StackTrace? stackTrace,
      }) {
    final errorMessage = error != null ? '$message: $error' : message;
    _log('❌', 'ERROR', errorMessage, name: name, level: 1000);

    if (stackTrace != null && isEnabled && _config.showStackTrace) {
      developer.log(
        stackTrace.toString(),
        name: '🔍 STACK_TRACE',
        time: DateTime.now(),
        level: 1000,
      );
    }
  }

  static void warning(String message, {String? name}) {
    _log('⚠️', 'WARNING', message, name: name, level: 900);
  }

  static void info(String message, {String? name}) {
    _log('ℹ️', 'INFO', message, name: name, level: 500);
  }

  static void debug(String message, {String? name}) {
    _log('🔍', 'DEBUG', message, name: name, level: 500);
  }

  static void verbose(String message, {String? name}) {
    _log('📝', 'VERBOSE', message, name: name, level: 300);
  }

  static void network(String message, {String? name}) {
    _log('🌐', 'NETWORK', message, name: name, level: 500);
  }

  static void database(String message, {String? name}) {
    _log('💾', 'DATABASE', message, name: name, level: 500);
  }

  static void auth(String message, {String? name}) {
    _log('🔑', 'AUTH', message, name: name, level: 700);
  }

  static void navigation(String message, {String? name}) {
    _log('🧭', 'NAVIGATION', message, name: name, level: 500);
  }

  static void ui(String message, {String? name}) {
    _log('🎨', 'UI', message, name: name, level: 400);
  }

  static void payment(String message, {String? name}) {
    _log('💳', 'PAYMENT', message, name: name, level: 700);
  }

  static void chat(String message, {String? name}) {
    _log('💬', 'CHAT', message, name: name, level: 500);
  }

  static void firebase(String message, {String? name}) {
    _log('🔥', 'FIREBASE', message, name: name, level: 500);
  }

  static void api(String message, {String? name}) {
    _log('🚀', 'API', message, name: name, level: 500);
  }

  static void file(String message, {String? name}) {
    _log('📁', 'FILE', message, name: name, level: 500);
  }

  static void notification(String message, {String? name}) {
    _log('🔔', 'NOTIFICATION', message, name: name, level: 600);
  }

  static void performance(String message, {String? name}) {
    _log('⏱️', 'PERFORMANCE', message, name: name, level: 700);
  }

  static void analytics(String message, {String? name}) {
    _log('📊', 'ANALYTICS', message, name: name, level: 500);
  }

  static void security(String message, {String? name}) {
    _log('🛡️', 'SECURITY', message, name: name, level: 900);
  }

  static void httpStatus(int statusCode, String endpoint, {String? method}) {
    final methodStr = method != null ? '$method ' : '';
    final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
    network('$emoji $methodStr$endpoint - Status: $statusCode');
  }

  static void httpBody(String body, {String type = 'BODY'}) {
    if (!_config.logHttpBodies) return;

    final maxLength = _config.maxBodyLength;
    final truncatedBody = body.length > maxLength
        ? '${body.substring(0, maxLength)}... (truncated ${body.length - maxLength} chars)'
        : body;
    network('$type: $truncatedBody');
  }

  static void json(dynamic jsonData, {String? description}) {
    final desc = description != null ? '$description: ' : '';
    debug('${desc}JSON: $jsonData');
  }

  static void userAction(String action, {Map<String, dynamic>? context}) {
    final contextStr = context != null ? ' | Context: $context' : '';
    info('👤 User: $action$contextStr');
  }

  static void stateChange(String from, String to, {String? component}) {
    final comp = component != null ? '[$component] ' : '';
    debug('${comp}State: $from → $to');
  }

  static void lifecycle(String event, {String? widget}) {
    final widgetStr = widget != null ? '[$widget] ' : '';
    ui('${widgetStr}Lifecycle: $event');
  }

  static void methodEntry(
      String className,
      String methodName, {
        Map<String, dynamic>? params,
      }) {
    if (!_config.logMethodCalls) return;
    final paramsStr = params != null ? ' | Params: $params' : '';
    verbose('→ $className.$methodName$paramsStr');
  }

  static void methodExit(
      String className,
      String methodName, {
        dynamic result,
      }) {
    if (!_config.logMethodCalls) return;
    final resultStr = result != null ? ' | Result: $result' : '';
    verbose('← $className.$methodName$resultStr');
  }

  static final Map<String, DateTime> _timers = {};
  static final Map<String, List<Duration>> _timerHistory = {};

  static void startTimer(String timerName) {
    _timers[timerName] = DateTime.now();
    performance('⏰ Timer started: $timerName');
  }

  static Duration? stopTimer(String timerName) {
    final startTime = _timers[timerName];
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      performance('⏰ Timer $timerName: ${duration.inMilliseconds}ms');

      _timerHistory.putIfAbsent(timerName, () => []).add(duration);
      _timers.remove(timerName);

      return duration;
    } else {
      warning('⏰ Timer $timerName was not started');
      return null;
    }
  }

  static Map<String, dynamic>? getTimerStats(String timerName) {
    final history = _timerHistory[timerName];
    if (history == null || history.isEmpty) return null;

    final totalMs = history.fold<int>(0, (sum, d) => sum + d.inMilliseconds);
    final avgMs = totalMs / history.length;
    final minMs = history.map((d) => d.inMilliseconds).reduce((a, b) => a < b ? a : b);
    final maxMs = history.map((d) => d.inMilliseconds).reduce((a, b) => a > b ? a : b);

    return {
      'count': history.length,
      'total': '${totalMs}ms',
      'average': '${avgMs.toStringAsFixed(2)}ms',
      'min': '${minMs}ms',
      'max': '${maxMs}ms',
    };
  }

  static void clearTimerHistory() {
    _timerHistory.clear();
    _timers.clear();
  }

  static void separator({String char = '=', int length = 50}) {
    debug(char * length);
  }

  static void section(String title) {
    separator();
    info('📌 $title');
    separator();
  }

  static void table(Map<String, dynamic> data, {String? title}) {
    if (title != null) info('📋 $title');

    data.forEach((key, value) {
      debug('  $key: $value');
    });
  }

  static void appStart() {
    section('APPLICATION STARTED');
    info('Environment: ${kDebugMode ? "Debug" : kReleaseMode ? "Release" : "Profile"}');
    info('Platform: ${defaultTargetPlatform.toString().split('.').last}');
  }

  static void clear() {
    clearTimerHistory();
    info('🧹 Logs cleared');
  }
}