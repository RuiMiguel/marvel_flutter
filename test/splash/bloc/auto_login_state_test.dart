// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/splash/bloc/auto_login_bloc.dart';

void main() {
  group('AutoLoginState', () {
    test('can be instantiated', () {
      expect(AutoLoginState.initial(), isNotNull);
    });

    test('has correct status', () {
      final state = AutoLoginState.initial();
      expect(state.status, AutoLoginStatus.initial);
    });

    group('copyWith', () {
      test('returns same object when no properties', () {
        expect(
          AutoLoginState(status: AutoLoginStatus.loading).copyWith(),
          AutoLoginState(status: AutoLoginStatus.loading),
        );
      });

      test('returns object with updated status when status is passed', () {
        expect(
          AutoLoginState(status: AutoLoginStatus.loading)
              .copyWith(status: AutoLoginStatus.success),
          AutoLoginState(status: AutoLoginStatus.success),
        );
      });
    });
  });
}
