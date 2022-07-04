// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';

void main() {
  group('AuthenticationState', () {
    test('can be instantiated', () {
      expect(AuthenticationState.initial(), isNotNull);
    });

    test('has correct status', () {
      final state = AuthenticationState.initial();
      expect(state.status, AuthenticationStatus.unauthenticated);
    });

    group('copyWith', () {
      test('returns same object when no properties', () {
        expect(
          AuthenticationState(status: AuthenticationStatus.unauthenticated)
              .copyWith(),
          AuthenticationState(status: AuthenticationStatus.unauthenticated),
        );
      });

      test('returns object with updated status when status is passed', () {
        expect(
          AuthenticationState(status: AuthenticationStatus.unauthenticated)
              .copyWith(status: AuthenticationStatus.authenticated),
          AuthenticationState(status: AuthenticationStatus.authenticated),
        );
      });
    });
  });
}
