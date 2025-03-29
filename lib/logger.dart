/// logger.t("Verbose log");
/// logger.d("Debug log");
/// logger.i("Info log");
/// logger.w("Warning log");
/// logger.e("Error log");
/// logger.f("What a terrible failure log");
library;

import 'package:logger/logger.dart';

// Create a global logger instance
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    // 'printTime' is deprecated and shouldn't be used. Use `dateTimeFormat` with `DateTimeFormat.onlyTimeAndSinceStart` or `DateTimeFormat.none` instead.
    // Try replacing the use of the deprecated member with the replacement.
  ),
);
