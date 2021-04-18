import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/commons/empty_content_view.dart';
import 'package:marvel/ui/commons/webview_screen.dart';
import 'package:marvel/ui/utils.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);
  static const String routeName = "character-details";

  final Character character;

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
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
        color: Section.characters.color, brightness: Brightness.light);

    _printDescriptionView() {
      var view;
      if (widget.character.description.isEmpty) {
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
              widget.character.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        );
      }
      return view;
    }

    _printLinksView() {
      var view;
      if (widget.character.urls.isEmpty) {
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

        widget.character.urls.forEach((element) {
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
                expandedHeight: _sliverAppHeight,
                floating: false,
                pinned: true,
                title: Visibility(
                  visible: isShrink,
                  child: Text(
                    widget.character.name,
                    maxLines: 1,
                  ),
                ),
                backgroundColor: Section.characters.color,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  collapseMode: CollapseMode.parallax,
                  title: Visibility(
                    visible: !isShrink,
                    child: Container(
                      child: Text(widget.character.name),
                      decoration: BoxDecoration(
                        color: blue.withAlpha(200),
                        backgroundBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),
                  titlePadding:
                      EdgeInsets.only(left: 40, bottom: 15, right: 20),
                  background: CachedNetworkImage(
                    imageUrl:
                        '${widget.character.thumbnail.path}/portrait_incredible.${widget.character.thumbnail.extension}',
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
                        widget.character.modified.parseDate(),
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
