import 'package:app_ui/app_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/webview/webview_page.dart';

class ComicDetailPage extends StatefulWidget {
  const ComicDetailPage({
    required this.comic,
    super.key,
  });

  static PageRoute page(Comic comic) => MaterialPageRoute<void>(
        builder: (context) => ComicDetailPage(
          comic: comic,
        ),
      );

  final Comic comic;

  @override
  State<ComicDetailPage> createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
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
          color: Theme.of(context).primaryColor,
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              _ComicSliverApp(
                sliverAppHeight: _sliverAppHeight,
                comic: widget.comic,
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
                    comic: widget.comic,
                  ),
                  _LinksView(
                    comic: widget.comic,
                  ),
                  const SizedBox(height: 20),
                  _PricesView(
                    comic: widget.comic,
                  ),
                  const SizedBox(height: 20),
                  _ImagesView(
                    comic: widget.comic,
                  ),
                  const SizedBox(height: 20),
                  _DatesView(
                    comic: widget.comic,
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

class _ComicSliverApp extends StatelessWidget {
  const _ComicSliverApp({
    required this.sliverAppHeight,
    required this.isShrink,
    required this.comic,
  });

  final double sliverAppHeight;
  final bool isShrink;
  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: sliverAppHeight,
      pinned: true,
      title: Visibility(
        visible: isShrink,
        child: Text(
          comic.title,
          maxLines: 1,
        ),
      ),
      backgroundColor: Section.comics.color,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Visibility(
          visible: !isShrink,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.blue.withAlpha(200),
              backgroundBlendMode: BlendMode.darken,
            ),
            child: Text(comic.title),
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 40, bottom: 15, right: 20),
        background: MarvelNetworkImage(
          imageUrl: comic.thumbnail.comicDetailPreview,
        ),
      ),
    );
  }
}

class _DescriptionView extends StatelessWidget {
  const _DescriptionView({required this.comic});

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return comic.description.isEmpty
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
                comic.description,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          );
  }
}

class _LinksView extends StatelessWidget {
  const _LinksView({required this.comic});

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    Widget view;
    if (comic.urls.isEmpty) {
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

      for (final element in comic.urls) {
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

class _PricesView extends StatelessWidget {
  const _PricesView({required this.comic});

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    Widget view;
    if (comic.prices.isEmpty) {
      view = EmptyView(
        title: l10n.prices,
        description: l10n.no_content,
      );
    } else {
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            l10n.prices,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 10),
        ],
      );

      for (final element in comic.prices) {
        (view as Column).children.add(
              Text(
                element.toCurrency(context),
                style: theme.textTheme.bodyLarge,
              ),
            );
      }
    }
    return view;
  }
}

class _ImagesView extends StatelessWidget {
  const _ImagesView({required this.comic});

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    Widget view;
    if (comic.images.isEmpty) {
      view = EmptyView(
        title: l10n.images,
        description: l10n.no_content,
      );
    } else {
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            l10n.images,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: comic.images.length,
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 3 / 4,
                child: MarvelNetworkImage(
                  imageUrl: comic.images[index].comicDetailGalleryPreview,
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
}

class _DatesView extends StatelessWidget {
  const _DatesView({required this.comic});

  final Comic comic;

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
          comic.modified,
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}

extension on Price {
  String toCurrency(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final currency = NumberFormat.simpleCurrency(locale: locale.toString());
    return '$price ${currency.currencySymbol}';
  }
}
