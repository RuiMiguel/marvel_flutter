// ignore_for_file: prefer_const_constructors

import 'package:app_ui/src/widgets/heroes_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HeroesAppBar', () {
    testWidgets(
      'renders correctly without actions',
      (tester) async {
        await tester.pumpGalleryWidget(
          Scaffold(
            appBar: HeroesAppBar(
              withActions: false,
              onLoginPressed: () {},
            ),
            body: Container(),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.actions, isEmpty);
        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets(
      'renders correctly with actions',
      (tester) async {
        await tester.pumpGalleryWidget(
          Scaffold(
            appBar: HeroesAppBar(
              withActions: true,
              onLoginPressed: () {},
            ),
            body: Container(),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.actions?.length, 1);
        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets(
      'runs onLoginPressed when LoginActionButton is pressed',
      (tester) async {
        var called = false;

        await tester.pumpGalleryWidget(
          Scaffold(
            appBar: HeroesAppBar(
              withActions: true,
              onLoginPressed: () {
                called = true;
              },
            ),
            body: Container(),
          ),
        );

        tester
            .widget<LoginActionButton>(find.byType(LoginActionButton))
            .onLoginPressed();

        await tester.pumpAndSettle();

        expect(called, isTrue);
      },
    );
  });
}
