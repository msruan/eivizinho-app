abstract class AppException extends Error {
  final String message;

  AppException(this.message);
}

class AppInternalExcpetion extends AppException {
  AppInternalExcpetion(super.message);
}
