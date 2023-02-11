import 'package:app_ui/src/widgets/info_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_gallery_widget.dart';

void main() {
  group('InfoView', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpGalleryWidget(
        const InfoView(
          legal: 'fake legal text',
          counter: '1 of 10',
        ),
      );

      expect(find.text('fake legal text'), findsOneWidget);
      expect(find.text('1 of 10'), findsOneWidget);
    });
  });
}
