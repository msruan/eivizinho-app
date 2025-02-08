abstract class ApplicationException implements Exception {
  final String message;

  const ApplicationException([this.message = ""]);

  @override
  String toString() => "ApplicationException -> $message";
}

class InternalSystemException extends ApplicationException {
  const InternalSystemException(super.message);

  @override
  String toString() => "InternalSystemException -> $message";
}

class InternetException extends ApplicationException {
  const InternetException(super.message);

  @override
  String toString() => "InternetException -> $message";
}
