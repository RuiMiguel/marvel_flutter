// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/login/bloc/login_bloc.dart';

void main() {
  group('LoginEvent', () {
    group('PrivateKeySetted', () {
      const privateKey = 'privateKey';

      test('supports equality comparisons', () {
        expect(
          PrivateKeySetted(privateKey),
          equals(PrivateKeySetted(privateKey)),
        );

        expect(
          PrivateKeySetted(privateKey),
          isNot(equals(PrivateKeySetted('other_privateKey'))),
        );
      });
    });

    group('PublicKeySetted', () {
      const publicKey = 'publicKey';

      test('supports equality comparisons', () {
        expect(
          PublicKeySetted(publicKey),
          equals(PublicKeySetted(publicKey)),
        );

        expect(
          PublicKeySetted(publicKey),
          isNot(equals(PublicKeySetted('other_publicKey'))),
        );
      });
    });

    group('Login', () {
      test('supports equality comparisons', () {
        expect(
          Login(),
          equals(Login()),
        );
      });
    });

    group('Logout', () {
      test('supports equality comparisons', () {
        expect(
          Logout(),
          equals(Logout()),
        );
      });
    });

    group('LoginSuccess', () {
      test('supports equality comparisons', () {
        expect(
          LoginSuccess(),
          equals(LoginSuccess()),
        );
      });
    });

    group('LoginFailure', () {
      test('supports equality comparisons', () {
        expect(
          LoginFailure(),
          equals(LoginFailure()),
        );
      });
    });
  });
}
