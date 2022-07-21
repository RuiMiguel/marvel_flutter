// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/characters.dart';
import 'package:marvel/characters/widget/info_view.dart';
import 'package:marvel/characters/widget/loading_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockCharactersBloc extends Mock implements CharactersBloc {}

void main() {
  late CharactersBloc charactersBloc;

  setUp(() {
    charactersBloc = _MockCharactersBloc();
  });

  group('CharactersPage', () {
    final characters = List.generate(
      4,
      (index) => Character(
        id: index,
        name: 'name',
        description: 'description',
        modified: 'modified',
        resourceURI: 'resourceURI',
        urls: List.empty(),
        thumbnail: const Thumbnail(path: 'path', extension: 'extension'),
      ),
    );

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          CharactersPage(),
        );

        expect(find.byType(CharactersView), findsOneWidget);
      },
    );

    group('CharactersView', () {
      testWidgets(
        'renders correctly',
        (tester) async {
          whenListen(
            charactersBloc,
            Stream.value(CharactersState.initial()),
            initialState: CharactersState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: charactersBloc,
              child: CharactersView(),
            ),
          );

          expect(
            find.byType(NotificationListener<ScrollNotification>),
            findsNWidgets(2),
          );
          expect(find.byType(CharactersViewContent), findsOneWidget);
          expect(find.byType(InfoView), findsOneWidget);
        },
      );

      group('NotificationListener', () {
        testWidgets(
          'add CharactersGotMore event when scrolled to end',
          (tester) async {
            whenListen(
              charactersBloc,
              Stream.value(
                CharactersState.initial().copyWith(
                  status: CharactersStatus.success,
                  characters: characters,
                ),
              ),
              initialState: CharactersState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: charactersBloc,
                child: CharactersView(),
              ),
            );

            final gesture = await tester.startGesture(const Offset(100, 100));
            await tester.pump();
            await gesture.moveBy(const Offset(0, -50));
            await tester.pump();
            await gesture.up();
            await tester.pump();

            verify(() => charactersBloc.add(CharactersGotMore())).called(1);
          },
        );

        testWidgets(
          "doesn't add CharactersGotMore event while not scrolled to end",
          (tester) async {
            whenListen(
              charactersBloc,
              Stream.value(
                CharactersState.initial().copyWith(
                  status: CharactersStatus.success,
                  characters: characters,
                ),
              ),
              initialState: CharactersState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: charactersBloc,
                child: CharactersView(),
              ),
            );

            final gesture = await tester.startGesture(const Offset(100, 100));
            await tester.pump();
            await gesture.moveBy(const Offset(0, -10));
            await tester.pump();
            await gesture.up();
            await tester.pump();

            verifyNever(() => charactersBloc.add(CharactersGotMore()));
          },
        );
      });

      group('CharactersViewContent', () {
        final binding = TestWidgetsFlutterBinding.ensureInitialized();

        testWidgets(
          'shows GridView when orientation is landscape',
          (tester) async {
            whenListen(
              charactersBloc,
              Stream.value(
                CharactersState.initial().copyWith(
                  status: CharactersStatus.success,
                  characters: characters,
                ),
              ),
              initialState: CharactersState.initial(),
            );

            await binding.setSurfaceSize(Size(800, 400));

            await tester.pumpApp(
              BlocProvider.value(
                value: charactersBloc,
                child: CharactersView(),
              ),
            );

            expect(find.byType(GridView), findsOneWidget);
            expect(find.byType(ListView), findsNothing);
          },
        );

        testWidgets(
          'shows ListView when orientation is portrait',
          (tester) async {
            whenListen(
              charactersBloc,
              Stream.value(
                CharactersState.initial().copyWith(
                  status: CharactersStatus.success,
                  characters: characters,
                ),
              ),
              initialState: CharactersState.initial(),
            );

            await binding.setSurfaceSize(Size(400, 800));

            await tester.pumpApp(
              BlocProvider.value(
                value: charactersBloc,
                child: CharactersView(),
              ),
            );

            expect(find.byType(ListView), findsOneWidget);
            expect(find.byType(GridView), findsNothing);
          },
        );

        group('CharacterElement', () {
          testWidgets(
            'test image and error builders',
            (tester) async {},
          );
        });
      });

      group('LoadingView', () {
        testWidgets(
          'shown when state is loading',
          (tester) async {
            whenListen(
              charactersBloc,
              Stream.value(
                CharactersState.initial()
                    .copyWith(status: CharactersStatus.loading),
              ),
              initialState: CharactersState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: charactersBloc,
                child: CharactersView(),
              ),
            );

            expect(find.byType(LoadingView), findsOneWidget);
          },
        );

        testWidgets(
          'hidden when state is not loading',
          (tester) async {
            whenListen(
              charactersBloc,
              Stream.value(
                CharactersState.initial()
                    .copyWith(status: CharactersStatus.success),
              ),
              initialState: CharactersState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: charactersBloc,
                child: CharactersView(),
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
              charactersBloc,
              Stream.value(
                CharactersState.initial().copyWith(
                  legal: 'fake legal test',
                  count: 1,
                  total: 10,
                ),
              ),
              initialState: CharactersState.initial(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: charactersBloc,
                child: CharactersView(),
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
