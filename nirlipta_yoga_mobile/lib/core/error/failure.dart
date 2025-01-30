abstract class Failure {
  final String message;
  final int? statusCode;

  Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message,
  });
}

class ApiFailure extends Failure {
  final int? statusCode;

  ApiFailure({
    this.statusCode,
    required super.message,
  });
}

class SharedPrefsFailure extends Failure {
  SharedPrefsFailure({
    required super.message,
  });
}
