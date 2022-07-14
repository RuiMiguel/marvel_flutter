// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/login/bloc/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('LoginBloc', () {
    const privateKey = 'privateKey';
    const publicKey = 'publicKey';

    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = _MockAuthenticationRepository();
    });

    group('PrivateKeySetted', () {
      blocTest<LoginBloc, LoginState>(
        'emits state with privateKey updated',
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(const PrivateKeySetted(privateKey)),
        expect: () => [
          isA<LoginState>().having(
            (e) => e.privateKey,
            'privateKey',
            equals(privateKey),
          ),
        ],
      );
    });

    group('PublicKeySetted', () {
      blocTest<LoginBloc, LoginState>(
        'emits state with publicKey updated',
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(PublicKeySetted(publicKey)),
        expect: () => [
          isA<LoginState>().having(
            (e) => e.publicKey,
            'publicKey',
            equals(publicKey),
          ),
        ],
      );
    });

    group('Login', () {
      final exception = Exception('error');

      blocTest<LoginBloc, LoginState>(
        'emits [loading, success] '
        'when login succeeded',
        setUp: () {
          when(
            () => authenticationRepository.login(
              privateKey: any(named: 'privateKey'),
              publicKey: any(named: 'publicKey'),
            ),
          ).thenAnswer((_) async {});
        },
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        seed: () => LoginState(
          privateKey: privateKey,
          publicKey: publicKey,
        ),
        act: (bloc) => bloc.add(Login()),
        expect: () => [
          isA<LoginState>().having(
            (e) => e.status,
            'status',
            LoginStatus.loading,
          ),
          isA<LoginState>()
              .having(
                (e) => e.status,
                'status',
                LoginStatus.success,
              )
              .having(
                (e) => e.privateKey,
                'privateKey',
                privateKey,
              )
              .having(
                (e) => e.publicKey,
                'publicKey',
                publicKey,
              ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, error] '
        'when login fails',
        setUp: () {
          when(
            () => authenticationRepository.login(
              privateKey: any(named: 'privateKey'),
              publicKey: any(named: 'publicKey'),
            ),
          ).thenThrow(exception);
        },
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(Login()),
        expect: () => [
          isA<LoginState>().having(
            (e) => e.status,
            'status',
            LoginStatus.loading,
          ),
          isA<LoginState>().having(
            (e) => e.status,
            'status',
            LoginStatus.failure,
          ),
        ],
        errors: () => equals([exception]),
      );
    });

    group('Logout', () {
      final exception = Exception('error');

      blocTest<LoginBloc, LoginState>(
        'emits [loading, success] '
        'when logout succeeded',
        setUp: () {
          when(
            () => authenticationRepository.logout(),
          ).thenAnswer((_) async {});
        },
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        seed: () => LoginState(
          privateKey: privateKey,
          publicKey: publicKey,
        ),
        act: (bloc) => bloc.add(Logout()),
        expect: () => [
          isA<LoginState>().having(
            (e) => e.status,
            'status',
            LoginStatus.loading,
          ),
          isA<LoginState>()
              .having(
                (e) => e.status,
                'status',
                LoginStatus.success,
              )
              .having(
                (e) => e.privateKey,
                'privateKey',
                isEmpty,
              )
              .having(
                (e) => e.publicKey,
                'publicKey',
                isEmpty,
              ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, error] '
        'when logout fails',
        setUp: () {
          when(
            () => authenticationRepository.logout(),
          ).thenThrow(exception);
        },
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(Logout()),
        expect: () => [
          isA<LoginState>().having(
            (e) => e.status,
            'status',
            LoginStatus.loading,
          ),
          isA<LoginState>().having(
            (e) => e.status,
            'status',
            LoginStatus.failure,
          ),
        ],
        errors: () => equals([exception]),
      );
    });
  });
}
