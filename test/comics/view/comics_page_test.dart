// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/comics/comics.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/under_construction/widget/under_construction_view.dart';

import '../../helpers/helpers.dart';

void main() {
  group('StoriesPage', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          ComicsPage(),
        );

        expect(find.byType(ComicsView), findsOneWidget);
      },
    );

    group('ComicsView', () {
      testWidgets(
        'renders correctly',
        (tester) async {
          final l10n = await AppLocalizations.delegate.load(const Locale('en'));

          await tester.pumpApp(
            ComicsView(),
          );

          expect(find.text(l10n.menu_comics), findsOneWidget);
          expect(find.byType(UnderConstructionView), findsOneWidget);
        },
      );
    });
  });
}
