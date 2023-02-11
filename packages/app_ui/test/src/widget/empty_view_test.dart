import 'package:app_ui/src/widgets/empty_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('EmptyView', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpGalleryWidget(
        const EmptyView(
          title: 'fake title',
          description: 'fake description',
        ),
      );

      expect(find.text('fake title'), findsOneWidget);
      expect(find.text('fake description'), findsOneWidget);
    });
  });
}
