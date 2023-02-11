// ignore_for_file: prefer_const_constructors

import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/character_detail/view/character_detail_page.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/webview/webview_page.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CharacterDetailPage', () {
    final character = Character(
      id: 1,
      name: 'name',
      description: 'description',
      modified: 'modified',
      resourceURI: 'resourceURI',
      urls: [
        CharacterUrl(type: 'type1', url: 'url1'),
        CharacterUrl(type: 'type2', url: 'url2'),
      ],
      thumbnail: Thumbnail(path: 'path', extension: 'extension'),
    );

    test('is routable', () {
      expect(CharacterDetailPage.page(character), isA<MaterialPageRoute>());
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        CharacterDetailPage(character: character),
      );

      expect(find.byType(WillPopScope), findsOneWidget);
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.text(character.name), findsOneWidget);

      expect(find.byType(CachedNetworkImage), findsOneWidget);
      final characterImage =
          tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
      expect(
        characterImage.imageUrl,
        character.thumbnail.characterDetailPreview,
      );
    });

    testWidgets(
      'test isShrink and scrollListener',
      (tester) async {},
    );

    testWidgets(
      'test SliverAppBar image and error builders',
      (tester) async {},
    );

    testWidgets('changes StatusBarTheme when go back', (tester) async {
      late Color primaryColor;
      late Brightness brightness;
      final log = <MethodCall>[];

      TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
          .setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );
      await tester.pumpApp(
        Builder(
          builder: (context) {
            primaryColor = Theme.of(context).primaryColor;
            brightness = Theme.of(context).brightness;
            return CharacterDetailPage(character: character);
          },
        ),
      );

      final popScope = tester.widget<WillPopScope>(find.byType(WillPopScope));
      await popScope.onWillPop!();

      expect(tester.binding.microtaskCount, equals(1));

      await tester.idle();

      expect(
        log.last,
        isMethodCall(
          'SystemChrome.setSystemUIOverlayStyle',
          arguments: <String, dynamic>{
            'statusBarColor': primaryColor.value,
            'statusBarIconBrightness': '$brightness',
            'systemNavigationBarColor': null,
            'systemNavigationBarDividerColor': null,
            'systemStatusBarContrastEnforced': null,
            'statusBarBrightness': null,
            'systemNavigationBarIconBrightness': null,
            'systemNavigationBarContrastEnforced': null,
          },
        ),
      );
    });

    group('DescriptionView', () {
      testWidgets('renders correctly with a description', (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          CharacterDetailPage(character: character),
        );

        expect(find.text(l10n.description), findsOneWidget);
        expect(find.text(character.description), findsOneWidget);
      });

      testWidgets('renders empty without a description', (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          CharacterDetailPage(character: character.copyWith(description: '')),
        );

        expect(find.byType(EmptyView), findsOneWidget);
        expect(find.text(l10n.description), findsOneWidget);
        expect(find.text(character.description), findsNothing);
      });
    });

    group('LinksView', () {
      testWidgets('renders links correctly', (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          CharacterDetailPage(character: character),
        );

        expect(find.text(l10n.links), findsOneWidget);
        expect(find.byType(TextLink), findsNWidgets(character.urls.length));
        for (final element in character.urls) {
          final textLink = tester.widget<TextLink>(
            find.byWidgetPredicate(
              (widget) =>
                  widget is TextLink &&
                  widget.url == element.url &&
                  widget.type == element.type,
            ),
          );

          expect(
            textLink,
            isNotNull,
          );
        }
      });

      testWidgets('renders empty without links', (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.pumpApp(
          CharacterDetailPage(character: character.copyWith(urls: [])),
        );

        expect(find.byType(EmptyView), findsOneWidget);
        expect(find.text(l10n.links), findsOneWidget);
        expect(find.byType(TextLink), findsNothing);
      });

      testWidgets('opens WebViewPage when link is tapped', (tester) async {
        await tester.pumpApp(
          CharacterDetailPage(character: character),
        );

        final textLink = tester.widget<TextLink>(find.byType(TextLink).first);
        textLink.onTap?.call();

        await tester.pump();
        await tester.pump();

        expect(
          find.byWidgetPredicate(
            (widget) => widget is WebViewPage && widget.url == textLink.url,
          ),
          findsOneWidget,
        );
      });
    });
  });
}
