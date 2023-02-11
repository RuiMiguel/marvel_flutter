// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/widgets/unauthenticated_buttons_view.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UnauthenticatedButtons', () {
    testWidgets(
      'renders correctly',
      (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          UnauthenticatedButtons(
            onLogin: () {},
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text(l10n.login), findsOneWidget);
      },
    );

    testWidgets(
      'onLogin called when button is enabled',
      (tester) async {
        var called = false;

        await tester.pumpApp(
          UnauthenticatedButtons(
            onLogin: () {
              called = true;
            },
          ),
        );

        tester
            .widget<ElevatedButton>(find.byType(ElevatedButton))
            .onPressed
            ?.call();
        expect(called, isTrue);
      },
    );

    testWidgets(
      'onLogin not called when button is disabled',
      (tester) async {
        var called = false;

        await tester.pumpApp(
          UnauthenticatedButtons(
            onLogin: () {
              called = true;
            },
            enabled: false,
          ),
        );

        tester
            .widget<ElevatedButton>(find.byType(ElevatedButton))
            .onPressed
            ?.call();

        expect(called, isFalse);
      },
    );
  });
}
