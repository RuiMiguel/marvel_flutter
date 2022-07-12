// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/home/widget/heroes_app_bar.dart';
import 'package:marvel/webview/webview_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webviewx/webviewx.dart';

import '../helpers/pump_app.dart';

class _MockWebViewXController extends Mock
    implements WebViewXController<dynamic> {}

void main() {
  const url = 'http://test.com';

  group('WebViewPage', () {
    final webViewXController = _MockWebViewXController();

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    test('is routable', () {
      expect(WebViewPage.page(url), isA<MaterialPageRoute>());
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          WebViewPage(
            url: url,
          ),
        );

        expect(find.byType(WillPopScope), findsOneWidget);
        expect(find.byType(HeroesAppBar), findsOneWidget);
        expect(find.byType(WebViewX), findsOneWidget);
      },
    );

    testWidgets(
      'shows progress indicator on creation',
      (tester) async {
        await tester.pumpApp(
          WebViewPage(
            url: url,
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'shows progress indicator while loading',
      (tester) async {
        await tester.pumpApp(
          WebViewPage(
            url: url,
          ),
        );

        tester.widget<WebViewX>(find.byType(WebViewX)).onPageStarted!(url);

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'hides progress indicator when finish loading',
      (tester) async {
        await tester.pumpApp(
          WebViewPage(
            url: url,
          ),
        );

        tester.widget<WebViewX>(find.byType(WebViewX)).onPageFinished!(url);

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    group('navigates', () {
      testWidgets(
        'can go back',
        (tester) async {
          when(webViewXController.canGoBack).thenAnswer((_) async => true);
          when(webViewXController.goBack).thenAnswer((_) async {});

          await tester.pumpApp(
            WebViewPage(
              url: url,
            ),
          );

          tester
              .widget<WebViewX>(find.byType(WebViewX))
              .onWebViewCreated!(webViewXController);

          final popScope =
              tester.widget<WillPopScope>(find.byType(WillPopScope));

          await popScope.onWillPop!();
          await tester.pump();

          verify(webViewXController.goBack).called(1);
        },
      );

      testWidgets(
        "can't go back",
        (tester) async {
          when(webViewXController.canGoBack).thenAnswer((_) async => false);

          await tester.pumpApp(
            WebViewPage(
              url: url,
            ),
          );

          tester
              .widget<WebViewX>(find.byType(WebViewX))
              .onWebViewCreated!(webViewXController);

          final popScope =
              tester.widget<WillPopScope>(find.byType(WillPopScope));

          await popScope.onWillPop!();
          await tester.pump();

          verifyNever(webViewXController.goBack);
        },
      );
    });
  });
}
