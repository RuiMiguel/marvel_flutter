import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/core/model/comic.dart' hide Image;
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/commons/empty_content_view.dart';
import 'package:marvel/ui/commons/webview_screen.dart';
import 'package:marvel/ui/utils.dart';

class ComicDetailScreen extends StatelessWidget {
  static const String routeName = "comic-details";

  final Comic comic;

  const ComicDetailScreen({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(
        color: Section.comics.color, brightness: Brightness.light);

    _printDescriptionView() {
      var view;
      if (comic.description.isEmpty) {
        view =
            EmptyContentView(title: AppLocalizations.of(context)!.description);
      } else {
        view = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.description,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            Text(
              comic.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        );
      }
      return view;
    }

    _printLinksView() {
      var view;
      if (comic.urls.isEmpty) {
        view = EmptyContentView(title: AppLocalizations.of(context)!.links);
      } else {
        view = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.links,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 10),
          ],
        );

        comic.urls.forEach((element) {
          view.children.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  WebViewScreen.routeName,
                  arguments: element.url,
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.link,
                    color: red,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${element.type}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 24,
                          color: red,
                        ),
                  ),
                ],
              ),
            ),
          );
        });
      }
      return view;
    }

    _printPricesView() {
      var view;
      if (comic.prices.isEmpty) {
        view = EmptyContentView(title: AppLocalizations.of(context)!.prices);
      } else {
        view = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.prices,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 10),
          ],
        );

        comic.prices.forEach((element) {
          view.children.add(
            Text(
              element.price.toCurrency(context),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        });
      }
      return view;
    }

    _printImagesView() {
      var view;
      if (comic.images.isEmpty) {
        view = EmptyContentView(title: AppLocalizations.of(context)!.images);
      } else {
        view = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.images,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: comic.images.length,
                itemBuilder: (context, index) => Image.network(
                  '${comic.images[index].path}/standard_amazing.${comic.images[index].extension}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return GestureDetector(
                      onTap: () {
                        print("Let's zoom image!");
                      },
                      child: Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, index) {
                  return Container(
                    color: Colors.black,
                    width: 2,
                  );
                },
              ),
            ),
          ],
        );
      }
      return view;
    }

    return WillPopScope(
      onWillPop: () {
        setStatusBarTheme(
          color: Theme.of(context).primaryColor,
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400,
                floating: false,
                pinned: true,
                //iconTheme: IconThemeData(color: Section.comics.color),
                backgroundColor: Section.comics.color,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  collapseMode: CollapseMode.parallax,
                  title: Text(comic.title),
                  titlePadding:
                      EdgeInsets.only(left: 45, bottom: 15, right: 15),
                  background: comic.thumbnail.path.isEmpty
                      ? Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          '${comic.thumbnail.path}/portrait_incredible.${comic.thumbnail.extension}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/placeholder.png',
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _printDescriptionView(),
                  _printLinksView(),
                  _printPricesView(),
                  _printImagesView(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.last_modified,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        comic.modified.parseDate(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
