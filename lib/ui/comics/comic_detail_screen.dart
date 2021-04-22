import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/core/model/comic.dart' hide Image;
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/commons/empty_content_view.dart';
import 'package:marvel/ui/commons/webview_screen.dart';
import 'package:marvel/ui/utils.dart';

class ComicDetailScreen extends StatefulWidget {
  const ComicDetailScreen({Key? key, required this.comic}) : super(key: key);
  static const String routeName = "comic-details";

  final Comic comic;

  @override
  _ComicDetailScreenState createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {
  ScrollController _scrollController = ScrollController();
  double _sliverAppHeight = 400;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (_sliverAppHeight - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(
        color: Section.comics.color, brightness: Brightness.light);

    _printDescriptionView() {
      var view;
      if (widget.comic.description.isEmpty) {
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
              widget.comic.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        );
      }
      return view;
    }

    _printLinksView() {
      var view;
      if (widget.comic.urls.isEmpty) {
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

        widget.comic.urls.forEach((element) {
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
      if (widget.comic.prices.isEmpty) {
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

        widget.comic.prices.forEach((element) {
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
      if (widget.comic.images.isEmpty) {
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
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.comic.images.length,
                itemBuilder: (context, index) => AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.network(
                    '${widget.comic.images[index].path}/standard_amazing.${widget.comic.images[index].extension}',
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
                ),
                separatorBuilder: (context, index) {
                  return Container(
                    color: Colors.black,
                    width: 5,
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
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400,
                floating: false,
                pinned: true,
                title: Visibility(
                  visible: isShrink,
                  child: Text(
                    widget.comic.title,
                    maxLines: 1,
                  ),
                ),
                backgroundColor: Section.comics.color,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  collapseMode: CollapseMode.parallax,
                  title: Visibility(
                    visible: !isShrink,
                    child: Container(
                      child: Text(widget.comic.title),
                      decoration: BoxDecoration(
                        color: green.withAlpha(200),
                        backgroundBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),
                  titlePadding:
                      EdgeInsets.only(left: 40, bottom: 15, right: 20),
                  background: CachedNetworkImage(
                    imageUrl:
                        '${widget.comic.thumbnail.path}/portrait_incredible.${widget.comic.thumbnail.extension}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitHeight,
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
                        widget.comic.modified.parseDate(),
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
