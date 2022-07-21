// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/widget/unauthenticated_description_view.dart';
import 'package:marvel/webview/webview_page.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UnauthenticatedDescription', () {
    testWidgets(
      'renders correctly',
      (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          UnauthenticatedDescription(),
        );

        final linkifyFinder = find.byType(Linkify);
        expect(linkifyFinder, findsOneWidget);
        expect(
          tester.widget<Linkify>(linkifyFinder).text,
          l10n.add_your_developer_credentials_to_login,
        );
      },
    );

    testWidgets(
      'opens WebViewPage when click on link',
      (tester) async {
        final link = LinkableElement('text', 'http://test.com');

        await tester.pumpApp(
          UnauthenticatedDescription(),
        );

        tester.widget<Linkify>(find.byType(Linkify)).onOpen!(link);

        await tester.pump();
        await tester.pump();

        expect(
          find.byWidgetPredicate(
            (widget) => widget is WebViewPage && widget.url == link.url,
          ),
          findsOneWidget,
        );
      },
    );
  });
}
