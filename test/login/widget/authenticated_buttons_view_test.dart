// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/widgets/authenticated_buttons_view.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthenticatedButtons', () {
    testWidgets(
      'renders correctly',
      (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          AuthenticatedButtons(
            onSave: () {},
            onLogout: () {},
          ),
        );

        expect(find.byKey(Key('save_button')), findsOneWidget);
        expect(find.byKey(Key('logout_button')), findsOneWidget);
        expect(find.text(l10n.save), findsOneWidget);
        expect(find.text(l10n.logout), findsOneWidget);
      },
    );

    group('onSave', () {
      testWidgets(
        'called when button is enabled',
        (tester) async {
          var called = false;

          await tester.pumpApp(
            AuthenticatedButtons(
              onSave: () {
                called = true;
              },
              onLogout: () {},
            ),
          );

          tester
              .widget<ElevatedButton>(find.byKey(Key('save_button')))
              .onPressed
              ?.call();
          expect(called, isTrue);
        },
      );

      testWidgets(
        'not called when button is disabled',
        (tester) async {
          var called = false;

          await tester.pumpApp(
            AuthenticatedButtons(
              onSave: () {
                called = true;
              },
              onLogout: () {},
              enabled: false,
            ),
          );

          tester
              .widget<ElevatedButton>(find.byKey(Key('save_button')))
              .onPressed
              ?.call();

          expect(called, isFalse);
        },
      );
    });

    group('onLogout', () {
      testWidgets(
        'called when button is enabled',
        (tester) async {
          var called = false;

          await tester.pumpApp(
            AuthenticatedButtons(
              onSave: () {},
              onLogout: () {
                called = true;
              },
            ),
          );

          tester
              .widget<ElevatedButton>(find.byKey(Key('logout_button')))
              .onPressed
              ?.call();
          expect(called, isTrue);
        },
      );

      testWidgets(
        'not called when button is disabled',
        (tester) async {
          var called = false;

          await tester.pumpApp(
            AuthenticatedButtons(
              onSave: () {},
              onLogout: () {
                called = true;
              },
              enabled: false,
            ),
          );

          tester
              .widget<ElevatedButton>(find.byKey(Key('logout_button')))
              .onPressed
              ?.call();
          expect(called, isFalse);
        },
      );
    });
  });
}
