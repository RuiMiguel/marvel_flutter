// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';

void main() {
  group('AuthenticationState', () {
    test('can be instantiated', () {
      expect(AuthenticationState.unauthenticated(), isNotNull);
    });

    test('has correct status', () {
      final state = AuthenticationState.unauthenticated();
      expect(state.status, AuthenticationStatus.unauthenticated);
    });

    group('copyWith', () {
      test('returns same object when no properties', () {
        expect(
          AuthenticationState(
            status: AuthenticationStatus.unauthenticated,
            user: User.anonymous(),
          ).copyWith(),
          AuthenticationState(
            status: AuthenticationStatus.unauthenticated,
            user: User.anonymous(),
          ),
        );
      });

      test('returns object with updated status when all parameters are passed',
          () {
        final newUser = User(
          privateKey: 'privateKey',
          publicKey: 'publicKey',
        );

        expect(
          AuthenticationState(
            status: AuthenticationStatus.unauthenticated,
            user: User.anonymous(),
          ).copyWith(
            status: AuthenticationStatus.authenticated,
            user: newUser,
          ),
          AuthenticationState(
            status: AuthenticationStatus.authenticated,
            user: newUser,
          ),
        );
      });
    });
  });
}
