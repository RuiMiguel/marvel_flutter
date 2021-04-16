import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/styles/colors.dart';
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
      color: index % 2 == 1 ? lightGrey : grey,
      child: InkWell(
        child: Container(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: character.thumbnail.path.isEmpty
                    ? Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        '${character.thumbnail.path}/portrait_incredible.${character.thumbnail.extension}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.fill,
                          );
                        },
                      ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.red.shade300.withOpacity(0.4),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    character.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
        splashColor: red,
        highlightColor: lightRed,
        onTap: () {
          Navigator.of(context).pushNamed(
            CharacterDetailScreen.routeName,
            arguments: character,
          );
        },
      ),
    );
  }
}
