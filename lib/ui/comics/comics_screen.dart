import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/comics_controller.dart';
import 'package:marvel/ui/comics/home_grid.dart';
import 'package:marvel/ui/comics/home_list.dart';
import 'package:provider/provider.dart';

class ComicsScreen extends StatelessWidget {
  const ComicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ComicsController>();

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return HomeListView(
            characters: List.empty(),
          );
        } else {
          return HomeGridView(
            characters: List.empty(),
          );
        }
      },
    );
  }
}
