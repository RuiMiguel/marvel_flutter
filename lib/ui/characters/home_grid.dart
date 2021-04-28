import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/ui/characters/home_grid_element.dart';

class HomeGridView extends StatefulWidget {
  const HomeGridView({Key? key, required this.characters}) : super(key: key);

  final List<Character>? characters;

  @override
  _HomeGridViewState createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridView> {
  List<Character> _characters = List.empty();

  _setData(List<Character>? list) {
    setState(() {
      if (list != null) {
        _characters = list;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _characters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1),
      itemBuilder: (context, index) {
        return HomeGridElement(
          index: index,
          character: _characters[index],
        );
      },
    );
  }
}
