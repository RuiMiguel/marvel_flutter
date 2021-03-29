import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart' hide Image;
import 'package:marvel/ui/comics/comic_detail_screen.dart';

class HomeListElement extends StatelessWidget {
  const HomeListElement({Key? key, required this.index, required this.comic})
      : super(key: key);

  final int index;
  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index % 2 == 1 ? Colors.grey[300] : Colors.grey[500],
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
                  color: Colors.grey.shade800.withOpacity(0.4),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    comic.title,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        splashColor: Colors.red[500],
        highlightColor: Colors.red[300],
        onTap: () {
          Navigator.of(context).pushNamed(
            ComicDetailScreen.routeName,
          );
        },
      ),
    );
  }
}
