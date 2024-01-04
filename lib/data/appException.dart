class AppException implements Exception {
  final _message;
  final _prefix;
  AppException(this._message, this._prefix);
  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error in communication:");
}

class UnAuthorizedRequest extends AppException {
  UnAuthorizedRequest([String? message])
      : super(message, "Unauthorized request:");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid request:");
}

class InternalServerError extends AppException {
  InternalServerError([String? message]) : super(message, "Server error:");
}
