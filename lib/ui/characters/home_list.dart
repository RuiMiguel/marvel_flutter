import 'package:flutter/material.dart';
import 'package:marvel/ui/characters/home_list_element.dart';
import 'package:marvel_domain/marvel_domain.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({Key? key, required this.characters}) : super(key: key);

  final List<Character>? characters;

  @override
  _HomeListViewState createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
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
    _setData(widget.characters);

    return ListView.separated(
      itemCount: _characters.length,
      itemBuilder: (context, index) {
        return HomeListElement(
          index: index,
          character: _characters[index],
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.black,
          height: 2,
        );
      },
    );
  }
}
