import 'package:logger/logger.dart';

final logger = AppLogger.instance;

class AppLogger {
  static AppLogger? _instance;
  static AppLogger get instance => _instance ??= AppLogger._init();

  late final Logger _logger;

  AppLogger._init() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 5,
        colors: true,
        printEmojis: true,
      ),
    );
  }

  void debug(dynamic message) => _logger.d(message);
  void info(dynamic message) => _logger.i(message);
  void warning(dynamic message) => _logger.w(message);
  void error(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
