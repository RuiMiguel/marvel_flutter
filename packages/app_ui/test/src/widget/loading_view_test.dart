import 'package:app_ui/src/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('LoadingView', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpGalleryWidget(
        const LoadingView(),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets(
      'test animationController repeat and forward',
      (tester) async {},
    );
  });
}
