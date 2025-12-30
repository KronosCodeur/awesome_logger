import 'package:flutter/material.dart';
import 'package:awesome_logger/awesome_logger.dart';

void main() {
  AwesomeLogger.configure(AwesomeLoggerConfig.development());

  AwesomeLogger.appStart();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Logger Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoggerDemoPage(),
    );
  }
}

class LoggerDemoPage extends StatefulWidget {
  const LoggerDemoPage({super.key});

  @override
  State<LoggerDemoPage> createState() => _LoggerDemoPageState();
}

class _LoggerDemoPageState extends State<LoggerDemoPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    context.log.lifecycle('initState');
  }

  @override
  void dispose() {
    context.log.lifecycle('dispose');
    super.dispose();
  }

  void _incrementCounter() {
    context.log.userAction('Button pressed', context: {'counter': _counter});

    setState(() {
      final oldValue = _counter;
      _counter++;

      context.log.stateChange('$oldValue', '$_counter');
    });
  }

  Future<void> _simulateApiCall() async {
    await context.log.measure('api_call', () async {
      context.log.api('Starting API call...');
      context.log.network('GET /api/users');

      await Future.delayed(const Duration(seconds: 2));

      context.log.httpStatus(200, '/api/users', method: 'GET');
      context.log.success('API call completed successfully');
    });
  }

  Future<void> _simulateError() async {
    try {
      context.log.warning('About to trigger an error');
      throw Exception('This is a simulated error');
    } catch (e, stack) {
      context.log.error('An error occurred', error: e, stackTrace: stack);
    }
  }

  void _demonstrateAllLogTypes() {
    AwesomeLogger.section('LOG TYPES DEMONSTRATION');

    AwesomeLogger.success('Operation completed successfully');
    AwesomeLogger.info('This is an informational message');
    AwesomeLogger.debug('Debug information');
    AwesomeLogger.verbose('Verbose details');
    AwesomeLogger.warning('This is a warning');
    AwesomeLogger.error('This is an error message');

    AwesomeLogger.separator();

    AwesomeLogger.network('Network request initiated');
    AwesomeLogger.database('Database query executed');
    AwesomeLogger.auth('User authenticated');
    AwesomeLogger.navigation('Navigated to home screen');
    AwesomeLogger.ui('Button rendered');
    AwesomeLogger.payment('Payment processed');
    AwesomeLogger.chat('Message sent');
    AwesomeLogger.firebase('Firebase event logged');
    AwesomeLogger.file('File saved');
    AwesomeLogger.notification('Notification received');
    AwesomeLogger.performance('Performance measured');
    AwesomeLogger.analytics('Analytics event tracked');
    AwesomeLogger.security('Security check passed');

    AwesomeLogger.separator();

    AwesomeLogger.table({
      'User ID': '12345',
      'Name': 'John Doe',
      'Email': 'john@example.com',
      'Status': 'Active',
    }, title: 'User Information');

    AwesomeLogger.json({
      'items': [1, 2, 3],
      'total': 100,
      'status': 'success'
    }, description: 'API Response');
  }

  void _demonstrateTimers() {
    context.log.info('Starting timer demonstration');

    AwesomeLogger.startTimer('demo_timer');

    for (int i = 0; i < 1000000; i++) {}

    AwesomeLogger.stopTimer('demo_timer');

    final stats = AwesomeLogger.getTimerStats('demo_timer');
    if (stats != null) {
      AwesomeLogger.table(stats, title: 'Timer Statistics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Logger Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Counter Value:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add),
                label: const Text('Increment (with logging)'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _simulateApiCall,
                icon: const Icon(Icons.cloud),
                label: const Text('Simulate API Call'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _simulateError,
                icon: const Icon(Icons.error),
                label: const Text('Simulate Error'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _demonstrateAllLogTypes,
                icon: const Icon(Icons.list),
                label: const Text('Show All Log Types'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _demonstrateTimers,
                icon: const Icon(Icons.timer),
                label: const Text('Demonstrate Timers'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Check your console to see the logs! 🚀',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}