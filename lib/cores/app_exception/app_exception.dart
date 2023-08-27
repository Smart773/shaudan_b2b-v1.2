class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message$_prefix';
  }
}

class InternetExceptions extends AppException {
  InternetExceptions([String? message]) : super(message, 'no internet here');
}

class TimeOutExceptions extends AppException {
  TimeOutExceptions([String? message]) : super(message, 'TimeOut');
}

class InvalidUrlExceptions extends AppException {
  InvalidUrlExceptions([String? message]) : super(message, 'Url not found');
}

class FetchDataExceptions extends AppException {
  FetchDataExceptions([String? message]) : super(message, 'Data Exception');
}

class UnauthorisedExceptions extends AppException {
  UnauthorisedExceptions([String? message]) : super(message, ' Unauthorised');
}

class InvalidInputExceptions extends AppException {
  InvalidInputExceptions([String? message]) : super(message, 'Invalid Input');
}
