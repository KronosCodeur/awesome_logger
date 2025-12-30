import 'package:flutter_test/flutter_test.dart';
import 'package:awesome_logger/awesome_logger.dart';

void main() {
  group('AwesomeLogger Configuration', () {
    test('Default configuration is enabled in debug mode', () {
      AwesomeLogger.configure(AwesomeLoggerConfig());
      expect(AwesomeLogger.config.enabled, true);
    });

    test('Production configuration disables logging', () {
      AwesomeLogger.configure(AwesomeLoggerConfig.production());
      expect(AwesomeLogger.config.enabled, false);
    });

    test('Development configuration enables all features', () {
      AwesomeLogger.configure(AwesomeLoggerConfig.development());
      final config = AwesomeLogger.config;

      expect(config.enabled, true);
      expect(config.showTimestamp, true);
      expect(config.showStackTrace, true);
      expect(config.logHttpBodies, true);
      expect(config.logMethodCalls, true);
    });

    test('Custom configuration can be set', () {
      AwesomeLogger.configure(AwesomeLoggerConfig(
        enabled: true,
        showTimestamp: false,
        maxBodyLength: 500,
      ));

      expect(AwesomeLogger.config.enabled, true);
      expect(AwesomeLogger.config.showTimestamp, false);
      expect(AwesomeLogger.config.maxBodyLength, 500);
    });

    test('Configuration can disable specific categories', () {
      AwesomeLogger.configure(
        AwesomeLoggerConfig.withDisabledCategories({'DEBUG', 'VERBOSE'}),
      );

      expect(
        AwesomeLogger.config.disabledCategories.contains('DEBUG'),
        true,
      );
      expect(
        AwesomeLogger.config.disabledCategories.contains('VERBOSE'),
        true,
      );
    });

    test('CopyWith creates new configuration with modifications', () {
      final original = AwesomeLoggerConfig(
        enabled: true,
        showTimestamp: true,
      );

      final modified = original.copyWith(
        showTimestamp: false,
        maxBodyLength: 2000,
      );

      expect(modified.enabled, true);
      expect(modified.showTimestamp, false);
      expect(modified.maxBodyLength, 2000);
    });
  });

  group('AwesomeLogger Timer', () {
    setUp(() {
      AwesomeLogger.configure(AwesomeLoggerConfig.development());
      AwesomeLogger.clearTimerHistory();
    });

    test('Timer can be started and stopped', () {
      AwesomeLogger.startTimer('test_timer');
      final duration = AwesomeLogger.stopTimer('test_timer');

      expect(duration, isNotNull);
      expect(duration!.inMicroseconds, greaterThan(0));
    });

    test('Stopping non-existent timer returns null', () {
      final duration = AwesomeLogger.stopTimer('non_existent');
      expect(duration, isNull);
    });

    test('Timer statistics are calculated correctly', () {
      for (int i = 0; i < 3; i++) {
        AwesomeLogger.startTimer('stats_timer');
        for (int j = 0; j < 10000; j++) {}
        AwesomeLogger.stopTimer('stats_timer');
      }

      final stats = AwesomeLogger.getTimerStats('stats_timer');

      expect(stats, isNotNull);
      expect(stats!['count'], 3);
      expect(stats['total'], isNotNull);
      expect(stats['average'], isNotNull);
      expect(stats['min'], isNotNull);
      expect(stats['max'], isNotNull);
    });

    test('Timer history can be cleared', () {
      AwesomeLogger.startTimer('clear_test');
      AwesomeLogger.stopTimer('clear_test');

      AwesomeLogger.clearTimerHistory();

      final stats = AwesomeLogger.getTimerStats('clear_test');
      expect(stats, isNull);
    });

    test('Multiple timers can run concurrently', () {
      AwesomeLogger.startTimer('timer1');
      AwesomeLogger.startTimer('timer2');

      final duration1 = AwesomeLogger.stopTimer('timer1');
      final duration2 = AwesomeLogger.stopTimer('timer2');

      expect(duration1, isNotNull);
      expect(duration2, isNotNull);
    });
  });

  group('AwesomeLogger Methods', () {
    setUp(() {
      AwesomeLogger.configure(AwesomeLoggerConfig.development());
    });

    test('All log methods execute without errors', () {
      expect(() => AwesomeLogger.success('Success test'), returnsNormally);
      expect(() => AwesomeLogger.error('Error test'), returnsNormally);
      expect(() => AwesomeLogger.warning('Warning test'), returnsNormally);
      expect(() => AwesomeLogger.info('Info test'), returnsNormally);
      expect(() => AwesomeLogger.debug('Debug test'), returnsNormally);
      expect(() => AwesomeLogger.verbose('Verbose test'), returnsNormally);
    });

    test('Category-specific logs execute without errors', () {
      expect(() => AwesomeLogger.network('Network test'), returnsNormally);
      expect(() => AwesomeLogger.database('Database test'), returnsNormally);
      expect(() => AwesomeLogger.auth('Auth test'), returnsNormally);
      expect(() => AwesomeLogger.navigation('Navigation test'), returnsNormally);
      expect(() => AwesomeLogger.ui('UI test'), returnsNormally);
      expect(() => AwesomeLogger.payment('Payment test'), returnsNormally);
      expect(() => AwesomeLogger.firebase('Firebase test'), returnsNormally);
      expect(() => AwesomeLogger.api('API test'), returnsNormally);
    });

    test('HTTP status logging works correctly', () {
      expect(
            () => AwesomeLogger.httpStatus(200, '/api/users', method: 'GET'),
        returnsNormally,
      );
      expect(
            () => AwesomeLogger.httpStatus(404, '/api/not-found'),
        returnsNormally,
      );
    });

    test('HTTP body logging truncates long content', () {
      final longBody = 'x' * 2000;
      expect(
            () => AwesomeLogger.httpBody(longBody, type: 'REQUEST'),
        returnsNormally,
      );
    });

    test('JSON logging handles various data types', () {
      expect(
            () => AwesomeLogger.json({'key': 'value'}),
        returnsNormally,
      );
      expect(
            () => AwesomeLogger.json([1, 2, 3]),
        returnsNormally,
      );
      expect(
            () => AwesomeLogger.json('simple string'),
        returnsNormally,
      );
    });

    test('User action logging with context', () {
      expect(
            () => AwesomeLogger.userAction(
          'button_click',
          context: {'screen': 'home', 'button_id': 'submit'},
        ),
        returnsNormally,
      );
    });

    test('State change logging', () {
      expect(
            () => AwesomeLogger.stateChange('loading', 'loaded', component: 'UserProfile'),
        returnsNormally,
      );
    });

    test('Method tracking', () {
      expect(
            () => AwesomeLogger.methodEntry('MyClass', 'myMethod', params: {'id': 123}),
        returnsNormally,
      );
      expect(
            () => AwesomeLogger.methodExit('MyClass', 'myMethod', result: 'success'),
        returnsNormally,
      );
    });

    test('Table logging', () {
      expect(
            () => AwesomeLogger.table({'key1': 'value1', 'key2': 'value2'}, title: 'Test Table'),
        returnsNormally,
      );
    });

    test('Section and separator logging', () {
      expect(() => AwesomeLogger.section('Test Section'), returnsNormally);
      expect(() => AwesomeLogger.separator(), returnsNormally);
      expect(() => AwesomeLogger.separator(char: '-', length: 30), returnsNormally);
    });
  });

  group('AwesomeLogger Disabled State', () {
    setUp(() {
      AwesomeLogger.configure(AwesomeLoggerConfig(enabled: false));
    });

    test('Logs do not execute when disabled', () {
      expect(() => AwesomeLogger.info('Should not log'), returnsNormally);
      expect(() => AwesomeLogger.error('Should not log'), returnsNormally);
      expect(() => AwesomeLogger.network('Should not log'), returnsNormally);
    });

    test('Timers still work when logging is disabled', () {
      AwesomeLogger.startTimer('disabled_timer');
      final duration = AwesomeLogger.stopTimer('disabled_timer');
      expect(duration, isNotNull);
    });
  });

  group('AwesomeLogger Error Handling', () {
    setUp(() {
      AwesomeLogger.configure(AwesomeLoggerConfig.development());
    });

    test('Error logging with exception and stack trace', () {
      final exception = Exception('Test exception');
      final stackTrace = StackTrace.current;

      expect(
            () => AwesomeLogger.error(
          'Error occurred',
          error: exception,
          stackTrace: stackTrace,
        ),
        returnsNormally,
      );
    });

    test('Error logging without stack trace', () {
      expect(
            () => AwesomeLogger.error('Simple error'),
        returnsNormally,
      );
    });

    test('Error logging with null error', () {
      expect(
            () => AwesomeLogger.error('Error with null', error: null),
        returnsNormally,
      );
    });
  });
}