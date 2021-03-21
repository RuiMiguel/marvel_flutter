import 'package:flutter/material.dart';
import 'package:marvel/ui/home/home_grid.dart';
import 'package:marvel/ui/home/home_list.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return HomeListView();
        } else {
          return HomeGridView();
        }
      },
    );
  }
}
