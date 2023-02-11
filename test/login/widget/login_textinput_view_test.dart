// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/login/widgets/login_textinput_view.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginTextInput', () {
    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          Scaffold(
            body: LoginTextInput(
              labelText: 'label',
              onChanged: (_) {},
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
      },
    );

    testWidgets(
      'calls onChange when text changes',
      (tester) async {
        var called = false;

        await tester.pumpApp(
          Scaffold(
            body: LoginTextInput(
              labelText: 'label',
              onChanged: (_) {
                called = true;
              },
            ),
          ),
        );

        final textFormField =
            tester.widget<TextFormField>(find.byType(TextFormField));
        textFormField.controller?.text = 'new';

        await tester.pump();

        expect(called, isTrue);
      },
    );
  });
}
