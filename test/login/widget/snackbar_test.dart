// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/login/widget/snackbar.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BuildContextX', () {
    testWidgets(
      'showErrorMessage shows a SnackBar correctly',
      (tester) async {
        const message = 'error';

        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  child: Text(
                    'press me',
                  ),
                  onPressed: () => context.showErrorMessage(message),
                );
              },
            ),
          ),
        );

        tester
            .widget<ElevatedButton>(find.byType(ElevatedButton))
            .onPressed
            ?.call();

        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          (tester.widget<SnackBar>(find.byType(SnackBar)).content as Text).data,
          message,
        );
      },
    );

    testWidgets(
      'showSuccessMessage shows a SnackBar correctly',
      (tester) async {
        const message = 'success';

        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  child: Text(
                    'press me',
                  ),
                  onPressed: () => context.showSuccessMessage(message),
                );
              },
            ),
          ),
        );

        tester
            .widget<ElevatedButton>(find.byType(ElevatedButton))
            .onPressed
            ?.call();

        await tester.pumpAndSettle();

        final snackBarFinder = find.byType(SnackBar);
        expect(snackBarFinder, findsOneWidget);
        expect(
          (tester.widget<SnackBar>(snackBarFinder).content as Text).data,
          message,
        );
      },
    );
  });
}
