import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/ui/characters/character_detail_screen.dart';

class HomeGridElement extends StatelessWidget {
  const HomeGridElement(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                character.name,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                'assets/images/placeholder.png',
                fit: BoxFit.contain,
                height: 80,
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
