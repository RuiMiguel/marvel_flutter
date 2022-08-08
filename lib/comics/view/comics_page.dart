import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_repository/comic_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:marvel/comics/comics.dart';
import 'package:marvel/comics/view/comic_detail_page.dart';
import 'package:marvel/common/widget/widget.dart';
import 'package:marvel/login/widget/widget.dart';
import 'package:marvel/styles/styles.dart';

class ComicsPage extends StatelessWidget {
  const ComicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComicsBloc(
        comicsRepository: context.read<ComicRepository>(),
      )..add(ComicsLoaded()),
      child: const ComicsView(),
    );
  }
}

@visibleForTesting
class ComicsView extends StatelessWidget {
  const ComicsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ComicsBloc>();

    return BlocConsumer<ComicsBloc, ComicsState>(
      listenWhen: (previous, current) => current.status.isError,
      listener: (context, state) {
        context.showErrorMessage('error');
      },
      builder: (context, state) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                scrollNotification.metrics.pixels ==
                    scrollNotification.metrics.maxScrollExtent) {
              bloc.add(ComicsGotMore());
              return true;
            } else {
              return false;
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ComicsViewContent(comics: state.comics),
                    Visibility(
                      visible: state.status.isLoading,
                      child: const LoadingView(),
                    ),
                  ],
                ),
              ),
              InfoView(
                legal: state.legal,
                count: state.count,
                total: state.total,
              ),
            ],
          ),
        );
      },
    );
  }
}

@visibleForTesting
class ComicsViewContent extends StatelessWidget {
  const ComicsViewContent({
    super.key,
    required this.comics,
  });

  final List<Comic> comics;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return _ComicsGridView(
          comics: comics,
        );
      },
    );
  }
}

class _ComicsGridView extends StatelessWidget {
  const _ComicsGridView({required this.comics});

  final List<Comic> comics;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    if (screenWidth > 2400) {
      _crossAxisCount = 8;
    }
    if (screenWidth <= 2400) {
      _crossAxisCount = 5;
    }
    if (screenWidth <= 1920) {
      _crossAxisCount = 3;
    }
    if (screenWidth <= 800) {
      _crossAxisCount = 2;
    }

    return GridView.builder(
      itemCount: comics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        return GridBoxDecoratedCell(
          index: index,
          gridViewCrossAxisCount: _crossAxisCount,
          child: ComicElement(
            index: index,
            comic: comics[index],
          ),
        );
      },
    );
  }
}

@visibleForTesting
class ComicElement extends StatelessWidget {
  const ComicElement({
    super.key,
    required this.index,
    required this.comic,
  });

  final int index;
  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index.isEven ? lightGrey : grey,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push<void>(
            ComicDetailPage.page(comic),
          );
        },
        splashColor: blue,
        highlightColor: lightBlue,
        child: SizedBox(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: comic.thumbnail.comicHomePreview,
                  cacheManager: context.read<CacheManager>(),
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
                  errorWidget: (context, url, dynamic error) => Image.asset(
                    'assets/images/error.jpeg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: blue.withOpacity(0.4),
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
