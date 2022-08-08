// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/domain.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/comics/comics.dart';
import 'package:marvel/common/widget/info_view.dart';
import 'package:marvel/common/widget/loading_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';

class _MockDefaultCacheManager extends Mock implements DefaultCacheManager {
  _MockDefaultCacheManager({this.fails = false});

  final bool fails;
  static const fileSystem = LocalFileSystem();

  @override
  Stream<FileResponse> getImageFile(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
    int? maxHeight,
    int? maxWidth,
  }) async* {
    if (fails) {
      throw Exception();
    } else {
      yield FileInfo(
        fileSystem.file('test/assets/image/placeholder.png'),
        FileSource.Cache,
        DateTime(
          DateTime.now().add(const Duration(days: 1)).year,
        ),
        url,
      );
    }
  }
}

class _MockComicsBloc extends Mock implements ComicsBloc {}

void main() {
  late ComicsBloc comicsBloc;

  setUp(() {
    comicsBloc = _MockComicsBloc();
  });

  group('ComicsPage', () {
    final comics = List.generate(
      4,
      (index) => Comic(
        id: index,
        digitalId: 1,
        title: 'title',
        issueNumber: 1,
        variantDescription: 'variantDescription',
        description: 'description',
        modified: 'modified',
        isbn: 'isbn',
        upc: 'upc',
        diamondCode: 'diamondCode',
        ean: 'ean',
        issn: 'issn',
        format: 'format',
        pageCount: 10,
        textObjects: [
          TextObject(type: 'type', language: 'language', text: 'text'),
        ],
        resourceURI: 'resourceURI',
        urls: [
          ComicUrl(type: 'type', url: 'url'),
        ],
        prices: [
          Price(type: 'type', price: 9.99),
        ],
        thumbnail: Thumbnail(
          path: 'path',
          extension: 'extension',
        ),
        images: [
          ComicImage(path: 'path', extension: 'extension'),
        ],
      ),
    );

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          ComicsPage(),
        );

        expect(find.byType(ComicsView), findsOneWidget);
      },
    );

    group('ComicsView', () {
      testWidgets(
        'renders correctly',
        (tester) async {
          whenListen(
            comicsBloc,
            Stream.value(ComicsState.initial()),
            initialState: ComicsState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: comicsBloc,
              child: ComicsView(),
            ),
          );

          expect(
            find.byType(NotificationListener<ScrollNotification>),
            findsNWidgets(2),
          );
          expect(find.byType(ComicsViewContent), findsOneWidget);
          expect(find.byType(InfoView), findsOneWidget);
        },
      );

      group('NotificationListener', () {
        testWidgets(
          'add ComicsGotMore event when scrolled to end',
          (tester) async {
            whenListen(
              comicsBloc,
              Stream.value(
                ComicsState.initial().copyWith(
                  status: ComicsStatus.success,
                  comics: comics,
                ),
              ),
              initialState: ComicsState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: comicsBloc,
                child: ComicsView(),
              ),
            );

            final gesture = await tester.startGesture(const Offset(100, 100));
            await tester.pump();
            await gesture.moveBy(const Offset(0, -50));
            await tester.pump();
            await gesture.up();
            await tester.pump();

            verify(() => comicsBloc.add(ComicsGotMore())).called(1);
          },
        );

        testWidgets(
          "doesn't add ComicsGotMore event while not scrolled to end",
          (tester) async {
            whenListen(
              comicsBloc,
              Stream.value(
                ComicsState.initial().copyWith(
                  status: ComicsStatus.success,
                  comics: comics,
                ),
              ),
              initialState: ComicsState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: comicsBloc,
                child: ComicsView(),
              ),
            );

            final gesture = await tester.startGesture(const Offset(100, 100));
            await tester.pump();
            await gesture.moveBy(const Offset(0, -10));
            await tester.pump();
            await gesture.up();
            await tester.pump();

            verifyNever(() => comicsBloc.add(ComicsGotMore()));
          },
        );
      });

      group('ComicsViewContent', () {
        final binding = TestWidgetsFlutterBinding.ensureInitialized();

        testWidgets(
          'renders correctly',
          (tester) async {
            whenListen(
              comicsBloc,
              Stream.value(
                ComicsState.initial().copyWith(
                  status: ComicsStatus.success,
                  comics: comics,
                ),
              ),
              initialState: ComicsState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: comicsBloc,
                child: ComicsView(),
              ),
            );

            expect(find.byType(GridView), findsOneWidget);
          },
        );

        group('ComicElement', () {
          testWidgets(
            'shows placeholder when load image returns error',
            (tester) async {
              final cacheManager = _MockDefaultCacheManager(
                fails: true,
              );

              await tester.pumpApp(
                Provider.value(
                  value: cacheManager,
                  child: ComicElement(
                    index: 1,
                    comic: comics.first,
                  ),
                ),
              );

              await tester.pumpAndSettle();

              final finder = find.byWidgetPredicate(
                (widget) =>
                    widget is Image &&
                    widget.image is AssetImage &&
                    (widget.image as AssetImage).assetName ==
                        'assets/images/error.jpeg',
              );
              expect(
                finder,
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'shows image when load image returns success',
            (tester) async {
              final comic = comics.first;

              final cacheManager = _MockDefaultCacheManager();

              await tester.pumpApp(
                Provider.value(
                  value: cacheManager,
                  child: ComicElement(
                    index: 1,
                    comic: comic,
                  ),
                ),
              );

              await tester.pumpAndSettle();

              final finder = find.byWidgetPredicate(
                (widget) =>
                    widget is Image &&
                    widget.image is CachedNetworkImageProvider &&
                    (widget.image as CachedNetworkImageProvider).url ==
                        comic.thumbnail.comicHomePreview,
              );

              expect(
                finder,
                findsOneWidget,
              );
            },
          );
        });
      });

      group('LoadingView', () {
        testWidgets(
          'shown when state is loading',
          (tester) async {
            whenListen(
              comicsBloc,
              Stream.value(
                ComicsState.initial().copyWith(status: ComicsStatus.loading),
              ),
              initialState: ComicsState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: comicsBloc,
                child: ComicsView(),
              ),
            );

            expect(find.byType(LoadingView), findsOneWidget);
          },
        );

        testWidgets(
          'hidden when state is not loading',
          (tester) async {
            whenListen(
              comicsBloc,
              Stream.value(
                ComicsState.initial().copyWith(status: ComicsStatus.success),
              ),
              initialState: ComicsState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: comicsBloc,
                child: ComicsView(),
              ),
            );

            expect(find.byType(LoadingView), findsNothing);
          },
        );
      });

      group('InfoView', () {
        testWidgets(
          'shows data from state',
          (tester) async {
            whenListen(
              comicsBloc,
              Stream.value(
                ComicsState.initial().copyWith(
                  legal: 'fake legal test',
                  count: 1,
                  total: 10,
                ),
              ),
              initialState: ComicsState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: comicsBloc,
                child: ComicsView(),
              ),
            );

            expect(find.byType(InfoView), findsOneWidget);
            final infoView = tester.widget<InfoView>(find.byType(InfoView));
            expect(infoView.legal, 'fake legal test');
            expect(infoView.count, 1);
            expect(infoView.total, 10);
          },
        );
      });
    });
  });
}
