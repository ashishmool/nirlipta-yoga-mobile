// Base Failure class
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

// LocalDatabaseFailure class
class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message,
  });
}

// ApiFailure class
class ApiFailure extends Failure {
  final int statusCode;

  ApiFailure({
    required this.statusCode,
    required super.message,
  });
}
