import '../constants/errors.dart';

class ErrorHandler {
  ErrorHandler._();

  static String getMessage(int errorCode, [String locale = "fr"]) {
    return errorCodes[errorCode]?[locale] ?? 'Invalid error';
  }
}
