import 'package:logger/logger.dart';

class Log {

  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void d(String message) {
    _logger.d(message);
  }

  static void i(String message) {
    _logger.i(message);
  }

  static void w(String message) {
    _logger.w(message);
  }

  static void e(String message) {
    _logger.e(message);
  }
  static void v(String message) => _logger.v(message);

  static void wtf(String message) => _logger.wtf(message);
}

// final Logger _logger = Logger(printer: PrettyPrinter());
// final customLog = (String fileClass) => Logger(printer: CustomPrinter(fileClass));
// class DefaultLog {
//
//   static void d(String message) {
//     _logger.d(message);
//   }
//
//   static void i(String message) {
//     _logger.i(message);
//   }
//
//   static void w(String message) {
//     _logger.w(message);
//   }
//
//   static void e(String message) {
//     _logger.e(message);
//   }
// }

// class CustomPrinter extends LogPrinter {
//   final String fileClassName;
//
//   CustomPrinter(this.fileClassName);
//
//   @override
//   List<String> log(LogEvent event) {
//     final color = PrettyPrinter.levelColors[event.level];
//     final emoji = PrettyPrinter.levelEmojis[event.level];
//     final message = event.level;
//
//     return [color!('$emoji [$fileClassName] $message')];
//   }
//
//   static void d(String FCName, String message) => customLog(FCName).d(message);
//
//   static void i(String FCName, String message) => customLog(FCName).i(message);
//
//   static void w(String FCName, String message) => customLog(FCName).w(message);
//
//   static void e(String FCName, String message) => customLog(FCName).e(message);
//
//   static void v(String FCName, String message) => customLog(FCName).v(message);
//
//   static void wtf(String FCName, String message) => customLog(FCName).wtf(message);
//
// }