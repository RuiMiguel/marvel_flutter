import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/characters/ui/character_detail_screen.dart';
import 'package:marvel_domain/marvel_domain.dart' hide Image;

class HomeListElement extends StatelessWidget {
  const HomeListElement(
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
                child: CachedNetworkImage(
                  imageUrl:
                      '${character.thumbnail.path}/landscape_amazing.${character.thumbnail.extension}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.contain,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: blue.withOpacity(0.4),
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
        splashColor: blue,
        highlightColor: lightBlue,
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
