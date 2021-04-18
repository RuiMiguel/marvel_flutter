import 'package:cached_network_image/cached_network_image.dart';
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
                child: CachedNetworkImage(
                  imageUrl:
                      '${comic.thumbnail.path}/landscape_amazing.${comic.thumbnail.extension}',
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
        splashColor: green,
        highlightColor: lightGreen,
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
