import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/characters/characters_screen.dart';
import 'package:marvel/ui/comics/comics_screen.dart';
import 'package:marvel/ui/commons/custom_appbar.dart';
import 'package:marvel/ui/commons/custom_bottomnavigationbar.dart';
import 'package:marvel/ui/series/series_screen.dart';
import 'package:marvel/ui/stories/stories_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  CustomBottomNavigationBar _buildCustomBottomNavigationBar() {
    var items = [
      CustomBottomNavigationItem(
        label: AppLocalizations.of(context)!.menu_characters,
        image: "assets/images/menu/Captain-America.png",
        color: _currentIndex == 0 ? Section.characters.color : lightGrey,
      ),
      CustomBottomNavigationItem(
        label: AppLocalizations.of(context)!.menu_comics,
        image: "assets/images/menu/Hulk.png",
        color: _currentIndex == 1 ? Section.comics.color : lightGrey,
      ),
      CustomBottomNavigationItem(
        label: AppLocalizations.of(context)!.menu_series,
        image: "assets/images/menu/Thor.png",
        color: _currentIndex == 2 ? Section.series.color : lightGrey,
      ),
      CustomBottomNavigationItem(
        label: AppLocalizations.of(context)!.menu_stories,
        image: "assets/images/menu/Iron-Man.png",
        color: _currentIndex == 3 ? Section.stories.color : lightGrey,
      ),
    ];

    return CustomBottomNavigationBar(
      children: items,
      currentIndex: _currentIndex,
      onChange: (index) {
        _changeIndex(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(
      color: Theme.of(context).primaryColor,
    );

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          child: IndexedStack(
            index: _currentIndex,
            children: [
              CharactersScreen(),
              ComicsScreen(),
              SeriesScreen(),
              StoriesScreen()
            ],
          ),
        ),
        bottomNavigationBar: _buildCustomBottomNavigationBar(),
      ),
    );
  }
}
