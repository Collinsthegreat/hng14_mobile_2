import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check if there's an existing session
class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

/// Event to start liveness verification
class StartLivenessVerification extends AuthEvent {
  const StartLivenessVerification();
}

/// Event when liveness verification succeeds
class LivenessVerificationSuccess extends AuthEvent {
  const LivenessVerificationSuccess();
}

/// Event when liveness verification fails
class LivenessVerificationFailure extends AuthEvent {
  const LivenessVerificationFailure();
}

/// Event to logout/clear session
class Logout extends AuthEvent {
  const Logout();
}
