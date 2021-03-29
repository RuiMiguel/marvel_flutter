import 'package:flutter/material.dart';
import 'package:marvel/ui/characters/characters_screen.dart';
import 'package:marvel/ui/comics/comics_screen.dart';
import 'package:marvel/ui/commons/custom_appbar.dart';
import 'package:marvel/ui/commons/custom_bottomnavigationbar.dart';
import 'package:marvel/ui/series/series_screen.dart';
import 'package:marvel/ui/stories/stories_screen.dart';

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
    var children2 = [
      CustomBottomNavigationItem(
        label: "Characters",
        image: "assets/images/menu/Captain-America.png",
        color: _currentIndex == 0 ? Colors.blue[200]! : Colors.grey[600]!,
      ),
      CustomBottomNavigationItem(
        label: "Comics",
        image: "assets/images/menu/Hulk.png",
        color: _currentIndex == 1 ? Colors.green[200]! : Colors.grey[600]!,
      ),
      CustomBottomNavigationItem(
        label: "Series",
        image: "assets/images/menu/Thor.png",
        color: _currentIndex == 2 ? Colors.yellow[200]! : Colors.grey[600]!,
      ),
      CustomBottomNavigationItem(
        label: "Stories",
        image: "assets/images/menu/Iron-Man.png",
        color: _currentIndex == 3 ? Colors.red[200]! : Colors.grey[600]!,
      ),
    ];
    return CustomBottomNavigationBar(
      children: children2,
      currentIndex: _currentIndex,
      onChange: (index) {
        _changeIndex(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
