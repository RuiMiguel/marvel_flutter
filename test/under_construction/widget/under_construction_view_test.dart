// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/under_construction/widget/under_construction_view.dart';

import '../../helpers/helpers.dart';

void main() {
  group('UnderConstructionView', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets(
      'renders a title',
      (tester) async {
        await tester.pumpApp(
          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    UnderConstructionView(),
                  ],
                ),
              ),
            ],
          ),
        );
        expect(find.text('We are under construction.'), findsNWidgets(1));
      },
    );

    testWidgets(
      'renders a default image',
      (tester) async {
        await tester.pumpApp(
          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    UnderConstructionView(),
                  ],
                ),
              ),
            ],
          ),
        );
        expect(find.byType(Image), findsNWidgets(1));
      },
    );

    testWidgets(
      'renders a sentence',
      (tester) async {
        await tester.pumpApp(
          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    UnderConstructionView(),
                  ],
                ),
              ),
            ],
          ),
        );

        final textView = find.byKey(Key('UnderConstructionSentence'));
        final sentence = (textView.evaluate().single.widget as Text).data;

        expect(textView, findsNWidgets(1));
        expect(sentence, isNotEmpty);
      },
    );
  });
}
