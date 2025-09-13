// create logger helper
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:logger/logger.dart';

class LoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      errorMethodCount: 8, // Number of error method calls to be displayed
      lineLength: 50,
      colors: true, // Colorize output
      printEmojis: true, // Print emojis in the log
      noBoxingByDefault: true,
      methodCount: 0,
    ),
  );

  static bool get _isDev {
    return AppConstants.ENVIRONMENT_SETTING == AppConstants.ENV_DEV;
  }

  static void logInfo(String message) {
    if (_isDev) _logger.i(message);
  }

  static void logWarning(String message) {
    if (_isDev) _logger.w(message);
  }

  static void logError(String message) {
    if (_isDev) _logger.e(message);
  }

  static void logDebug(String message) {
    if (_isDev) _logger.d(message);
  }
}
