import 'package:flutter/material.dart';
import 'package:marvel/ui/home/home_grid.dart';
import 'package:marvel/ui/home/home_list.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return HomeListView();
        } else {
          return HomeGridView();
        }
      },
    );
  }
}
