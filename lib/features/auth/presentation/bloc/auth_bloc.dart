import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Box _authBox;

  static const String _sessionKey = 'liveness_verified';
  static const String _failureCountKey = 'failure_count';
  static const String _lockUntilKey = 'lock_until';
  static const int _maxFailures = 3;
  static const int _lockoutDurationSeconds = 30;

  Timer? _lockoutTimer;

  AuthBloc(@Named('auth_box') this._authBox) : super(const AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<StartLivenessVerification>(_onStartLivenessVerification);
    on<LivenessVerificationSuccess>(_onLivenessVerificationSuccess);
    on<LivenessVerificationFailure>(_onLivenessVerificationFailure);
    on<Logout>(_onLogout);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Check if user is locked out
      final lockUntilStr = _authBox.get(_lockUntilKey) as String?;
      if (lockUntilStr != null) {
        final lockUntil = DateTime.parse(lockUntilStr);
        if (DateTime.now().isBefore(lockUntil)) {
          final remainingSeconds = lockUntil.difference(DateTime.now()).inSeconds;
          emit(AuthLocked(lockUntil: lockUntil, remainingSeconds: remainingSeconds));
          _startLockoutTimer(lockUntil);
          return;
        } else {
          _authBox.delete(_lockUntilKey);
          _authBox.delete(_failureCountKey);
        }
      }

      final session = _authBox.get(_sessionKey);
      if (session != null) {
        emit(const Authenticated());
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onStartLivenessVerification(StartLivenessVerification event, Emitter<AuthState> emit) async {
    emit(const AuthVerifying());
  }

  Future<void> _onLivenessVerificationSuccess(LivenessVerificationSuccess event, Emitter<AuthState> emit) async {
    try {
      await _authBox.put(_sessionKey, DateTime.now().toIso8601String());
      await _authBox.delete(_failureCountKey);
      await _authBox.delete(_lockUntilKey);
      emit(const AuthVerificationSuccess());
      await Future.delayed(const Duration(seconds: 2));
      emit(const Authenticated());
    } catch (e) {
      emit(const AuthVerificationFailed(failureCount: 0, message: 'Failed to save session'));
    }
  }

  Future<void> _onLivenessVerificationFailure(LivenessVerificationFailure event, Emitter<AuthState> emit) async {
    try {
      final currentCount = _authBox.get(_failureCountKey, defaultValue: 0) as int;
      final newCount = currentCount + 1;
      await _authBox.put(_failureCountKey, newCount);

      if (newCount >= _maxFailures) {
        final lockUntil = DateTime.now().add(const Duration(seconds: _lockoutDurationSeconds));
        await _authBox.put(_lockUntilKey, lockUntil.toIso8601String());
        emit(AuthLocked(lockUntil: lockUntil, remainingSeconds: _lockoutDurationSeconds));
        _startLockoutTimer(lockUntil);
      } else {
        emit(AuthVerificationFailed(failureCount: newCount, message: 'Verification failed. ${_maxFailures - newCount} attempts remaining.'));
      }
    } catch (e) {
      emit(const AuthVerificationFailed(failureCount: 0, message: 'An error occurred'));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    try {
      await _authBox.delete(_sessionKey);
      emit(const Unauthenticated());
    } catch (e) {
      emit(const Unauthenticated());
    }
  }

  void _startLockoutTimer(DateTime lockUntil) {
    _lockoutTimer?.cancel();
    _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.isAfter(lockUntil)) {
        timer.cancel();
        add(const CheckAuthStatus());
      } else {
        final remainingSeconds = lockUntil.difference(now).inSeconds;
        // Use add instead of emit to avoid the warning
        // The state will be updated through the event handler
        if (state is AuthLocked &&
            (state as AuthLocked).remainingSeconds != remainingSeconds) {
          // Only trigger update if the remaining seconds changed
          add(const CheckAuthStatus());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _lockoutTimer?.cancel();
    return super.close();
  }
}
