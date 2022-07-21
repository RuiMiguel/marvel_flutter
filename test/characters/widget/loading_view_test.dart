import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/widget/loading_view.dart';

import '../../helpers/helpers.dart';

void main() {
  group('LoadingView', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        const LoadingView(),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets(
      'test isShrink and scrollListener',
      (tester) async {},
    );
  });
}
