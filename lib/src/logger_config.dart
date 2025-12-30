class AwesomeLoggerConfig {
  final bool enabled;

  final bool forceEnable;

  final bool showTimestamp;

  final bool showStackTrace;

  final bool logHttpBodies;

  final bool logMethodCalls;

  final int maxBodyLength;

  final Set<String> disabledCategories;

  final int minLevel;

  const AwesomeLoggerConfig({
    this.enabled = true,
    this.forceEnable = false,
    this.showTimestamp = true,
    this.showStackTrace = true,
    this.logHttpBodies = true,
    this.logMethodCalls = false,
    this.maxBodyLength = 1000,
    this.disabledCategories = const {},
    this.minLevel = 0,
  });

  factory AwesomeLoggerConfig.production() {
    return const AwesomeLoggerConfig(
      enabled: false,
      showTimestamp: false,
      showStackTrace: false,
      logHttpBodies: false,
      logMethodCalls: false,
      minLevel: 1000,
    );
  }

  factory AwesomeLoggerConfig.development() {
    return const AwesomeLoggerConfig(
      enabled: true,
      showTimestamp: true,
      showStackTrace: true,
      logHttpBodies: true,
      logMethodCalls: true,
      minLevel: 0,
    );
  }

  factory AwesomeLoggerConfig.withDisabledCategories(
      Set<String> categories,
      ) {
    return AwesomeLoggerConfig(
      disabledCategories: categories,
    );
  }

  AwesomeLoggerConfig copyWith({
    bool? enabled,
    bool? forceEnable,
    bool? showTimestamp,
    bool? showStackTrace,
    bool? logHttpBodies,
    bool? logMethodCalls,
    int? maxBodyLength,
    Set<String>? disabledCategories,
    int? minLevel,
  }) {
    return AwesomeLoggerConfig(
      enabled: enabled ?? this.enabled,
      forceEnable: forceEnable ?? this.forceEnable,
      showTimestamp: showTimestamp ?? this.showTimestamp,
      showStackTrace: showStackTrace ?? this.showStackTrace,
      logHttpBodies: logHttpBodies ?? this.logHttpBodies,
      logMethodCalls: logMethodCalls ?? this.logMethodCalls,
      maxBodyLength: maxBodyLength ?? this.maxBodyLength,
      disabledCategories: disabledCategories ?? this.disabledCategories,
      minLevel: minLevel ?? this.minLevel,
    );
  }
}