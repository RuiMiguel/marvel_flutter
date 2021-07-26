import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/ui/comics/comic_detail_screen.dart';
import 'package:marvel_domain/marvel_domain.dart' hide Image;

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
        onTap: () {
          Navigator.of(context).pushNamed(
            ComicDetailScreen.routeName,
            arguments: comic,
          );
        },
        splashColor: green,
        highlightColor: lightGreen,
        child: Container(
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl:
                      '${comic.thumbnail.path}/landscape_amazing.${comic.thumbnail.extension}',
                  placeholder: (context, url) => Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.contain,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.contain,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: green.withOpacity(0.4),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    comic.title,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
