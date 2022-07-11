import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/l10n/l10n.dart';

import '../helpers/helpers.dart';

void main() {
  group('AppLocalizationsX', () {
    testWidgets('performs localizations lookup', (tester) async {
      await tester.pumpApp(
        Builder(
          builder: (context) => Text(context.l10n.success),
        ),
      );
      expect(find.text('Success („• ֊ •„)੭'), findsOneWidget);
    });
  });
}
