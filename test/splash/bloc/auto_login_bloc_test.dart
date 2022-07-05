// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/splash/bloc/auto_login_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('AutoLoginBloc', () {
    const privateKey = 'privateKey';
    const publicKey = 'publicKey';

    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = _MockAuthenticationRepository();
      when(() => authenticationRepository.privateKey())
          .thenAnswer((_) async => privateKey);
      when(() => authenticationRepository.publicKey())
          .thenAnswer((_) async => publicKey);
    });

    group('AutoLogin', () {
      final exception = Exception('error');

      blocTest<AutoLoginBloc, AutoLoginState>(
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
        build: () => AutoLoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AutoLogin()),
        expect: () => <AutoLoginState>[
          AutoLoginState(status: AutoLoginStatus.loading),
          AutoLoginState(status: AutoLoginStatus.success),
        ],
      );

      blocTest<AutoLoginBloc, AutoLoginState>(
        'emits [loading, error] '
        'when privateKey fails',
        setUp: () {
          when(
            () => authenticationRepository.privateKey(),
          ).thenThrow(exception);
          when(() => authenticationRepository.logout())
              .thenAnswer((_) async {});
        },
        build: () => AutoLoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AutoLogin()),
        expect: () => <AutoLoginState>[
          AutoLoginState(status: AutoLoginStatus.loading),
          AutoLoginState(status: AutoLoginStatus.error),
        ],
        errors: () => equals([exception]),
      );

      blocTest<AutoLoginBloc, AutoLoginState>(
        'emits [loading, error] '
        'when publicKey fails',
        setUp: () {
          when(
            () => authenticationRepository.publicKey(),
          ).thenThrow(exception);
          when(() => authenticationRepository.logout())
              .thenAnswer((_) async {});
        },
        build: () => AutoLoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AutoLogin()),
        expect: () => <AutoLoginState>[
          AutoLoginState(status: AutoLoginStatus.loading),
          AutoLoginState(status: AutoLoginStatus.error),
        ],
        errors: () => equals([exception]),
      );

      blocTest<AutoLoginBloc, AutoLoginState>(
        'emits [loading, error] '
        'when login fails',
        setUp: () {
          when(
            () => authenticationRepository.login(
              privateKey: any(named: 'privateKey'),
              publicKey: any(named: 'publicKey'),
            ),
          ).thenThrow(exception);
          when(() => authenticationRepository.logout())
              .thenAnswer((_) async {});
        },
        build: () => AutoLoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AutoLogin()),
        expect: () => <AutoLoginState>[
          AutoLoginState(status: AutoLoginStatus.loading),
          AutoLoginState(status: AutoLoginStatus.error),
        ],
        errors: () => equals([exception]),
      );

      blocTest<AutoLoginBloc, AutoLoginState>(
        'call logout '
        'when authenticationRepository fails',
        setUp: () {
          when(
            () => authenticationRepository.login(
              privateKey: any(named: 'privateKey'),
              publicKey: any(named: 'publicKey'),
            ),
          ).thenThrow(exception);
          when(() => authenticationRepository.logout())
              .thenAnswer((_) async {});
        },
        build: () => AutoLoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AutoLogin()),
        verify: (_) {
          verify(() => authenticationRepository.logout()).called(1);
        },
      );
    });
  });
}
