import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/characters/characters.dart';
import 'package:marvel/comics/comics.dart';
import 'package:marvel/home/home.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/login.dart';
import 'package:marvel/series/series.dart';
import 'package:marvel/stories/stories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static PageRoute page() =>
      MaterialPageRoute<void>(builder: (context) => const HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SectionCubit(),
      child: const HomeView(),
    );
  }
}

@visibleForTesting
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    theme.setStatusBarTheme(
      color: theme.primaryColor,
    );

    return SafeArea(
      child: BlocBuilder<SectionCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: HeroesAppBar(
              withActions: true,
              onLoginPressed: () => Navigator.of(context).push<void>(
                LoginPage.page(),
              ),
            ),
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
                HeroBottomNavigationItem(
                  label: l10n.menu_characters,
                  image: MarvelIcons.menu.captainAmerica,
                  color: state == 0
                      ? Section.characters.color
                      : AppColors.lightGrey,
                ),
                HeroBottomNavigationItem(
                  label: l10n.menu_comics,
                  image: MarvelIcons.menu.hulk,
                  color:
                      state == 1 ? Section.comics.color : AppColors.lightGrey,
                ),
                HeroBottomNavigationItem(
                  label: l10n.menu_series,
                  image: MarvelIcons.menu.thor,
                  color:
                      state == 2 ? Section.series.color : AppColors.lightGrey,
                ),
                HeroBottomNavigationItem(
                  label: l10n.menu_stories,
                  image: MarvelIcons.menu.ironMan,
                  color:
                      state == 3 ? Section.stories.color : AppColors.lightGrey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
