import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/common/widget/empty_view.dart';
import 'package:marvel/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  group('EmptyView', () {
    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.pumpApp(
        const EmptyView(title: 'fake title'),
      );

      expect(find.text('fake title'), findsOneWidget);
      expect(find.text(l10n.no_content), findsOneWidget);
    });
  });
}
