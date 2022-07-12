// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/view/characters_page.dart';
import 'package:marvel/comics/view/comics_page.dart';
import 'package:marvel/home/cubit/section_cubit.dart';
import 'package:marvel/home/view/home_page.dart';
import 'package:marvel/home/widget/heroes_app_bar.dart';
import 'package:marvel/home/widget/heroes_bottom_navigation_bar.dart';
import 'package:marvel/series/view/series_page.dart';
import 'package:marvel/stories/view/stories_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockSectionCubit extends Mock implements SectionCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomePage', () {
    test('is routable', () {
      expect(HomePage.page(), isA<MaterialPageRoute>());
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          HomePage(),
        );

        expect(find.byType(HomeView), findsOneWidget);
      },
    );

    group('HomeView', () {
      late SectionCubit sectionCubit;

      setUp(() {
        sectionCubit = _MockSectionCubit();
      });

      testWidgets(
        'renders correctly',
        (tester) async {
          whenListen(
            sectionCubit,
            Stream.value(1),
            initialState: 1,
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: sectionCubit,
              child: HomeView(),
            ),
          );

          expect(find.byType(HeroesAppBar), findsOneWidget);
          expect(find.byType(HeroesBottomNavigationBar), findsOneWidget);
          expect(find.byType(IndexedStack), findsOneWidget);
          final stack = tester.widget<IndexedStack>(find.byType(IndexedStack));

          expect(stack.children.length, 4);
          expect(find.byType(CharactersPage), findsOneWidget);
          expect(find.byType(ComicsPage), findsOneWidget);
          expect(find.byType(SeriesPage), findsOneWidget);
          expect(find.byType(StoriesPage), findsOneWidget);
        },
      );

      testWidgets(
        'page selected is SectionCubit state',
        (tester) async {
          whenListen(
            sectionCubit,
            Stream.value(1),
            initialState: 1,
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: sectionCubit,
              child: HomeView(),
            ),
          );

          expect(
            tester.widget<IndexedStack>(find.byType(IndexedStack)).index,
            1,
          );
        },
      );
    });
  });
}
