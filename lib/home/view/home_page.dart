import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/characters/characters.dart';
import 'package:marvel/comics/comics.dart';
import 'package:marvel/home/cubit/section_cubit.dart';
import 'package:marvel/home/widget/widget.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/series/series.dart';
import 'package:marvel/stories/stories.dart';
import 'package:marvel/styles/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SectionCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: BlocBuilder<SectionCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: const HeroesAppBar(withActions: true),
            body: IndexedStack(
              index: state,
              children: const [
                CharactersPage(),
                ComicsPage(),
                SeriesPage(),
                StoriesPage(),
              ],
            ),
            bottomNavigationBar: HeroesBottomNavigationBar(
              items: [
                CustomBottomNavigationItem(
                  label: l10n.menu_characters,
                  image: 'assets/images/menu/Captain-America.png',
                  color: state == 0 ? Section.characters.color : lightGrey,
                ),
                CustomBottomNavigationItem(
                  label: l10n.menu_comics,
                  image: 'assets/images/menu/Hulk.png',
                  color: state == 1 ? Section.comics.color : lightGrey,
                ),
                CustomBottomNavigationItem(
                  label: l10n.menu_series,
                  image: 'assets/images/menu/Thor.png',
                  color: state == 2 ? Section.series.color : lightGrey,
                ),
                CustomBottomNavigationItem(
                  label: l10n.menu_stories,
                  image: 'assets/images/menu/Iron-Man.png',
                  color: state == 3 ? Section.stories.color : lightGrey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
