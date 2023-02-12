import 'package:app_ui/app_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/webview/webview_page.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({
    required this.character,
    super.key,
  });

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
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () {
        theme.setStatusBarTheme(
          color: theme.primaryColor,
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
        title: Visibility(
          visible: !isShrink,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.blue.withAlpha(200),
              backgroundBlendMode: BlendMode.darken,
            ),
            child: Text(character.name),
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 40, bottom: 15, right: 20),
        background: MarvelNetworkImage(
          imageUrl: character.thumbnail.characterDetailPreview,
        ),
      ),
    );
  }
}

class _DescriptionView extends StatelessWidget {
  const _DescriptionView({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return character.description.isEmpty
        ? EmptyView(
            title: l10n.description,
            description: l10n.no_content,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                l10n.description,
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Text(
                character.description,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          );
  }
}

class _LinksView extends StatelessWidget {
  const _LinksView({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    Widget view;
    if (character.urls.isEmpty) {
      view = EmptyView(
        title: l10n.links,
        description: l10n.no_content,
      );
    } else {
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            l10n.links,
            style: theme.textTheme.displayMedium,
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
    required this.url,
    required this.type,
    required this.onTap,
    super.key,
  });

  final String url;
  final String type;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          const Icon(
            Icons.link,
            color: AppColors.red,
          ),
          const SizedBox(width: 10),
          Text(
            type,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 24,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _DatesView extends StatelessWidget {
  const _DatesView({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          l10n.last_modified,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(width: 10),
        Text(
          character.modified,
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
