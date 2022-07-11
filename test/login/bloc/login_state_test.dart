// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/login/bloc/login_bloc.dart';

void main() {
  group('LoginState', () {
    test('can be instantiated', () {
      expect(LoginState(), isNotNull);
    });

    test('has correct status', () {
      final state = LoginState();
      expect(state.status, LoginStatus.initial);
      expect(state.privateKey, '');
      expect(state.publicKey, '');
    });

    group('copyWith', () {
      test('returns same object when no properties', () {
        expect(
          LoginState().copyWith(),
          LoginState(),
        );
      });

      test('returns object with updated status when all parameters are passed',
          () {
        const privateKey = 'privateKey';
        const publicKey = 'publicKey';

        expect(
          LoginState().copyWith(
            status: LoginStatus.success,
            privateKey: privateKey,
            publicKey: publicKey,
          ),
          LoginState(
            status: LoginStatus.success,
            privateKey: privateKey,
            publicKey: publicKey,
          ),
        );
      });
    });
  });

  group('LoginStatusX', () {
    test('LoginStatus.initial isInitial is true', () {
      const status = LoginStatus.initial;

      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('LoginStatus.loading isLoading is true', () {
      const status = LoginStatus.loading;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('LoginStatus.success isSuccess is true', () {
      const status = LoginStatus.success;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('LoginStatus.failure isFailure is true', () {
      const status = LoginStatus.failure;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });
  });
}
