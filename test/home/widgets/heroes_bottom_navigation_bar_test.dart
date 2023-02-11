// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/home/cubit/section_cubit.dart';
import 'package:marvel/home/widgets/heroes_bottom_navigation_bar.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockSectionCubit extends Mock implements SectionCubit {}

void main() {
  late SectionCubit sectionCubit;

  final items = [
    HeroBottomNavigationItem(
      label: 'item_1',
      image: MarvelIcons.menu.captainAmerica,
      color: Section.characters.color,
    ),
    HeroBottomNavigationItem(
      label: 'item_2',
      image: MarvelIcons.menu.hulk,
      color: Section.comics.color,
    ),
    HeroBottomNavigationItem(
      label: 'item_3',
      image: MarvelIcons.menu.thor,
      color: Section.series.color,
    ),
    HeroBottomNavigationItem(
      label: 'item_4',
      image: MarvelIcons.menu.ironMan,
      color: Section.stories.color,
    ),
  ];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    sectionCubit = _MockSectionCubit();
  });

  group('HeroesBottomNavigationBar', () {
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
            child: Scaffold(
              body: Container(),
              bottomNavigationBar: HeroesBottomNavigationBar(items: items),
            ),
          ),
        );

        expect(find.byType(BottomNavigationBar), findsOneWidget);
        final navigationBar = tester
            .widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
        expect(navigationBar.items.length, items.length);
      },
    );

    testWidgets(
      'calls selectItem on SectionCubit when tap on item',
      (tester) async {
        whenListen(
          sectionCubit,
          Stream.value(1),
          initialState: 1,
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: sectionCubit,
            child: Scaffold(
              body: Container(),
              bottomNavigationBar: HeroesBottomNavigationBar(items: items),
            ),
          ),
        );

        (tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar)))
            .onTap!(2);

        await tester.pumpAndSettle();

        verify(
          () => sectionCubit.selectItem(2),
        ).called(1);
      },
    );
  });
}
