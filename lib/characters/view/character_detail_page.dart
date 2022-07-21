import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:marvel/characters/widget/widget.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/styles/styles.dart';
import 'package:marvel/webview/webview_page.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({super.key, required this.character});

  static PageRoute page(Character character) => MaterialPageRoute<void>(
        builder: (context) => CharacterDetailPage(
          character: character,
        ),
      );

  final Character character;

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  bool lastStatus = true;
  final ScrollController _scrollController = ScrollController();
  final double _sliverAppHeight = 400;

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (_sliverAppHeight - kToolbarHeight);
  }

  Future<void> _scrollListener() async {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
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
    return WillPopScope(
      onWillPop: () {
        Theme.of(context).setStatusBarTheme(
          color: Theme.of(context).primaryColor,
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              _CharacterSliverApp(
                sliverAppHeight: _sliverAppHeight,
                character: widget.character,
                isShrink: _isShrink,
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DescriptionView(
                    character: widget.character,
                  ),
                  _LinksView(
                    character: widget.character,
                  ),
                  const SizedBox(height: 20),
                  _DatesView(
                    character: widget.character,
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

class _CharacterSliverApp extends StatelessWidget {
  const _CharacterSliverApp({
    super.key,
    required this.sliverAppHeight,
    required this.isShrink,
    required this.character,
  });

  final double sliverAppHeight;
  final bool isShrink;
  final Character character;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: sliverAppHeight,
      floating: false,
      pinned: true,
      title: Visibility(
        visible: isShrink,
        child: Text(
          character.name,
          maxLines: 1,
        ),
      ),
      backgroundColor: Section.characters.color,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        collapseMode: CollapseMode.parallax,
        title: Visibility(
          visible: !isShrink,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: blue.withAlpha(200),
              backgroundBlendMode: BlendMode.darken,
            ),
            child: Text(character.name),
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 40, bottom: 15, right: 20),
        background: CachedNetworkImage(
          imageUrl:
              '${character.thumbnail.path}/portrait_incredible.${character.thumbnail.extension}',
          imageBuilder: (context, imageProvider) => DecoratedBox(
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
          errorWidget: (BuildContext context, String url, dynamic error) =>
              Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _DescriptionView extends StatelessWidget {
  const _DescriptionView({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return character.description.isEmpty
        ? EmptyView(title: l10n.description)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                l10n.description,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 10),
              Text(
                character.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          );
  }
}

class _LinksView extends StatelessWidget {
  const _LinksView({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    Widget view;
    if (character.urls.isEmpty) {
      view = EmptyView(title: l10n.links);
    } else {
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            l10n.links,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10),
        ],
      );

      for (final element in character.urls) {
        (view as Column).children.add(
              TextLink(
                url: element.url,
                type: element.type,
                onTap: () {
                  Navigator.of(context).push<void>(
                    WebViewPage.page(element.url),
                  );
                },
              ),
            );
      }
    }
    return view;
  }
}

@visibleForTesting
class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.url,
    required this.type,
    required this.onTap,
  });

  final String url;
  final String type;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          const Icon(
            Icons.link,
            color: red,
          ),
          const SizedBox(width: 10),
          Text(
            type,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 24,
                  color: red,
                ),
          ),
        ],
      ),
    );
  }
}

class _DatesView extends StatelessWidget {
  const _DatesView({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          l10n.last_modified,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(width: 10),
        Text(
          character.modified,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
