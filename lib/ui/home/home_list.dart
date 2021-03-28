import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/ui/home/home_list_element.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({Key? key, required this.characters}) : super(key: key);

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return HomeListElement(
          index: index,
          character: characters[index],
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
