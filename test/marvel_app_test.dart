import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/marvel_app.dart';
import 'package:marvel/ui/auth_screen.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:marvel/ui/login/login_screen.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers_test.dart';

void main() {
  group('MarvelApp', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders MarvelApp AuthScreen', (tester) async {
      await tester.pumpWidget(MarvelApp(
        prefs: await SharedPreferences.getInstance(),
      ));
      expect(find.byType(AuthScreen), findsOneWidget);
    });
  });

  group('AuthScreen', () {
    testWidgets('renders LoginScreen when user unauthenticated',
        (tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(MarvelApp(
        prefs: await SharedPreferences.getInstance(),
      ));
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('renders HomeScreen when user authenticated', (tester) async {
      var fakePrivateKey = "FAKE_PRIVATE_KEY";
      var fakePublicKey = "FAKE_PUBLIC_KEY";
      SharedPreferences.setMockInitialValues(
        {
          DatastoreManager.PRIVATE_KEY: fakePrivateKey,
          DatastoreManager.PUBLICK_KEY: fakePublicKey,
        },
      );

      await tester.pumpWidget(MarvelApp(
        prefs: await SharedPreferences.getInstance(),
      ));
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
