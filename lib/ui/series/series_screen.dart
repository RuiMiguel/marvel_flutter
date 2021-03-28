import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/characters_controller.dart';
import 'package:marvel/ui/home/home_grid.dart';
import 'package:marvel/ui/home/home_list.dart';
import 'package:provider/provider.dart';

class SeriesScreen extends StatelessWidget {
  const SeriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<CharactersController>();

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return HomeListView(
            characters: controller.characters,
          );
        } else {
          return HomeGridView(
            characters: controller.characters,
          );
        }
      },
    );
  }
}
