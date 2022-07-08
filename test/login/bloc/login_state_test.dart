// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
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
}
