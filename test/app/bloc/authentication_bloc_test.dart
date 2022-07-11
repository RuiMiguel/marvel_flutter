// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  final newUser = User(
    privateKey: 'privateKey',
    publicKey: 'publicKey',
  );

  late AuthenticationRepository authenticationRepository;
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    authenticationRepository = _MockAuthenticationRepository();
    when(() => authenticationRepository.user).thenAnswer(
      (_) => Stream.empty(),
    );

    authenticationBloc = AuthenticationBloc(
      authenticationRepository: authenticationRepository,
    );
  });

  tearDown(() {
    authenticationBloc.close();
  });

  group('AuthenticationBloc', () {
    group('CredentialsChanged', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [authenticated] '
        'when authenticationRepository credentials emits true',
        build: () => authenticationBloc,
        seed: () => AuthenticationState(
          status: AuthenticationStatus.unauthenticated,
          user: User.anonymous(),
        ),
        act: (bloc) => bloc.add(CredentialsChanged(user: newUser)),
        expect: () => <AuthenticationState>[
          AuthenticationState(
            status: AuthenticationStatus.authenticated,
            user: newUser,
          ),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [unauthenticated] '
        'when authenticationRepository credentials emits false',
        build: () => authenticationBloc,
        seed: () => AuthenticationState(
          status: AuthenticationStatus.authenticated,
          user: newUser,
        ),
        act: (bloc) => bloc.add(CredentialsChanged(user: User.anonymous())),
        expect: () => <AuthenticationState>[
          AuthenticationState(
            status: AuthenticationStatus.unauthenticated,
            user: User.anonymous(),
          ),
        ],
      );
    });
  });
}
