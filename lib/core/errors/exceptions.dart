/// Custom exceptions for the Expense Tracker application.
/// These exceptions are thrown by data sources and caught by repositories
/// to be converted into Failures.
library;

/// Exception thrown when storage operations fail (Hive, SecureStorage).
class StorageException implements Exception {
  final String message;

  const StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}

/// Exception thrown when input validation fails.
class ValidationException implements Exception {
  final String message;

  const ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when authentication/liveness verification fails.
class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Exception thrown when network operations fail.
class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}
