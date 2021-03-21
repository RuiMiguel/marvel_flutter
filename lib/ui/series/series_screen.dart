import 'package:flutter/material.dart';
import 'package:marvel/ui/home/home_grid.dart';
import 'package:marvel/ui/home/home_list.dart';

class SeriesScreen extends StatelessWidget {
  const SeriesScreen({Key key}) : super(key: key);

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
