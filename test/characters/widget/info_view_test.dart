import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/widget/info_view.dart';
import 'package:marvel/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  group('InfoView', () {
    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.pumpApp(
        const InfoView(
          legal: 'fake legal text',
          count: 1,
          total: 10,
        ),
      );

      expect(find.text('fake legal text'), findsOneWidget);
      expect(find.text('1 ${l10n.of_message} 10'), findsOneWidget);
    });
  });
}
