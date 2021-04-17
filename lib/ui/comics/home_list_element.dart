import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart' hide Image;
import 'package:marvel/styles/colors.dart';
import 'package:marvel/ui/comics/comic_detail_screen.dart';

class HomeListElement extends StatelessWidget {
  const HomeListElement({Key? key, required this.index, required this.comic})
      : super(key: key);

  final int index;
  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index % 2 == 1 ? lightGrey : grey,
      child: InkWell(
        child: Container(
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: comic.thumbnail.path.isEmpty
                    ? Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        '${comic.thumbnail.path}/landscape_amazing.${comic.thumbnail.extension}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.contain,
                          );
                        },
                      ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: green.withOpacity(0.4),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    comic.title,
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
            ComicDetailScreen.routeName,
            arguments: comic,
          );
        },
      ),
    );
  }
}
