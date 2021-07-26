import 'package:flutter/material.dart';
import 'package:marvel/characters/ui/home_grid_element.dart';
import 'package:marvel_domain/marvel_domain.dart';

class HomeGridView extends StatefulWidget {
  const HomeGridView({Key? key, required this.characters}) : super(key: key);

  final List<Character>? characters;

  @override
  _HomeGridViewState createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridView> {
  List<Character> _characters = List.empty();

  Future<void> _setData(List<Character>? list) async => setState(() {
        if (list != null) {
          _characters = list;
        }
      });

  @override
  Widget build(BuildContext context) {
    _setData(widget.characters);

    return GridView.builder(
      itemCount: _characters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
