import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import '../characters/character_detail_screen.dart';

class HomeListElement extends StatelessWidget {
  const HomeListElement(
      {Key? key, required this.index, required this.character})
      : super(key: key);

  final int index;
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index % 2 == 1 ? Colors.grey[300] : Colors.grey[500],
      child: InkWell(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                character.title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset(
                'assets/images/placeholder.png',
                fit: BoxFit.contain,
                height: 150,
              ),
            ],
          ),
        ),
        splashColor: Colors.red[500],
        highlightColor: Colors.red[300],
        onTap: () {
          Navigator.of(context).pushNamed(
            CharacterDetailScreen.routeName,
          );
        },
      ),
    );
  }
}
