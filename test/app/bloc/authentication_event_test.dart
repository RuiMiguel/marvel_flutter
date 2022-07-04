// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';

void main() {
  group('AuthenticationEvent', () {
    group('CredentialsChanged', () {
      test('supports equality comparisons', () {
        expect(
          CredentialsChanged(authenticated: true),
          equals(CredentialsChanged(authenticated: true)),
        );

        expect(
          CredentialsChanged(authenticated: true),
          isNot(equals(CredentialsChanged(authenticated: false))),
        );
      });
    });
  });
}
