import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/ui/comics/home_grid_element.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({Key? key, required this.characters}) : super(key: key);

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: characters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1),
      itemBuilder: (context, index) {
        return HomeGridElement(
          index: index,
          character: characters[index],
        );
      },
    );
  }
}
