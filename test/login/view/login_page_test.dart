// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/login/view/login_page.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    test('is routable', () {
      expect(LoginPage.page(), isA<MaterialPageRoute>());
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          LoginPage(),
        );

        expect(find.byType(LoginView), findsOneWidget);
      },
    );
  });
}
