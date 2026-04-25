import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthBloc authBloc;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockSecureStorage();
    authBloc = AuthBloc(mockSecureStorage);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, const AuthInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [Authenticated] when session exists',
      build: () {
        when(() => mockSecureStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => 'verified');
        return authBloc;
      },
      act: (bloc) => bloc.add(const CheckAuthStatus()),
      expect: () => [const Authenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Unauthenticated] when no session exists',
      build: () {
        when(() => mockSecureStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => null);
        return authBloc;
      },
      act: (bloc) => bloc.add(const CheckAuthStatus()),
      expect: () => [const Unauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerifying] when verification starts',
      build: () => authBloc,
      act: (bloc) => bloc.add(const StartLivenessVerification()),
      expect: () => [const AuthVerifying()],
    );
  });
}
