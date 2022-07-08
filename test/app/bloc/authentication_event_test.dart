// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';

void main() {
  group('AuthenticationEvent', () {
    final user = User(
      privateKey: 'privateKey',
      publicKey: 'publicKey',
    );

    group('CredentialsChanged', () {
      test('supports equality comparisons', () {
        expect(
          CredentialsChanged(user: user),
          equals(CredentialsChanged(user: user)),
        );

        expect(
          CredentialsChanged(user: user),
          isNot(equals(CredentialsChanged(user: User.anonymous()))),
        );
      });
    });
  });
}
