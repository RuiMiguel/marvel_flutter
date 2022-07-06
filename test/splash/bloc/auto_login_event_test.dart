// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/splash/bloc/auto_login_bloc.dart';

void main() {
  group('AutoLogin', () {
    test('supports equality comparisons', () {
      expect(
        AutoLogin(),
        equals(AutoLogin()),
      );
    });
  });
}
