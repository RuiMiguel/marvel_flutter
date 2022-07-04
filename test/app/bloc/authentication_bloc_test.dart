// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('AuthenticationBloc', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = _MockAuthenticationRepository();
      when(() => authenticationRepository.credentials).thenAnswer(
        (_) => Stream.empty(),
      );
    });

    group('CredentialsChanged', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [authenticated] '
        'when authenticationRepository credentials emits true',
        build: () => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        seed: () =>
            AuthenticationState(status: AuthenticationStatus.unauthenticated),
        act: (bloc) => bloc.add(CredentialsChanged(authenticated: true)),
        expect: () => <AuthenticationState>[
          AuthenticationState(status: AuthenticationStatus.authenticated),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [unauthenticated] '
        'when authenticationRepository credentials emits false',
        setUp: () {
          when(() => authenticationRepository.credentials).thenAnswer(
            (_) => Stream.value(true),
          );
        },
        build: () => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        seed: () =>
            AuthenticationState(status: AuthenticationStatus.unauthenticated),
        act: (bloc) => bloc
          ..add(CredentialsChanged(authenticated: true))
          ..add(CredentialsChanged(authenticated: false)),
        expect: () => <AuthenticationState>[
          AuthenticationState(status: AuthenticationStatus.unauthenticated),
        ],
      );
    });
  });
}
