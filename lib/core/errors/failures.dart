import 'package:equatable/equatable.dart';

/// Abstract base class for all failures in the application.
/// All failures extend this class to provide consistent error handling.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure that occurs during storage operations (Hive, SecureStorage).
class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

/// Failure that occurs during input validation.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Failure that occurs during authentication/liveness verification.
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

/// Failure that occurs during network operations.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
