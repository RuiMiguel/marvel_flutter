// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/widget/authenticated_description_view.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthenticatedDescription', () {
    testWidgets(
      'renders correctly',
      (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          AuthenticatedDescription(),
        );

        expect(find.text(l10n.your_current_credentials), findsOneWidget);
      },
    );
  });
}
