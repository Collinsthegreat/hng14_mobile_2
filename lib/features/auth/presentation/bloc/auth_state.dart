import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state - checking for existing session
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// User is authenticated (has valid session)
class Authenticated extends AuthState {
  const Authenticated();
}

/// User is not authenticated (no session)
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Liveness verification in progress
class AuthVerifying extends AuthState {
  const AuthVerifying();
}

/// Liveness verification succeeded
class AuthVerificationSuccess extends AuthState {
  const AuthVerificationSuccess();
}

/// Liveness verification failed
class AuthVerificationFailed extends AuthState {
  final int failureCount;
  final String message;

  const AuthVerificationFailed({
    required this.failureCount,
    required this.message,
  });

  @override
  List<Object?> get props => [failureCount, message];
}

/// User is locked out after 3 failed attempts
class AuthLocked extends AuthState {
  final DateTime lockUntil;
  final int remainingSeconds;

  const AuthLocked({required this.lockUntil, required this.remainingSeconds});

  @override
  List<Object?> get props => [lockUntil, remainingSeconds];
}
