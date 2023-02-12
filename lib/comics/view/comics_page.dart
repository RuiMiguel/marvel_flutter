import 'package:app_ui/app_ui.dart';
import 'package:comic_repository/comic_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/comic_detail/comic_detail.dart';
import 'package:marvel/comics/comics.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/widgets/widgets.dart';

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
    final l10n = context.l10n;

    final bloc = context.read<ComicsBloc>();

    return BlocConsumer<ComicsBloc, ComicsState>(
      listenWhen: (previous, current) => current.status.isError,
      listener: (context, state) {
        context.showErrorMessage(l10n.generic_error);
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
                counter: '${state.count} ${l10n.of_message} ${state.total}',
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
    required this.comics,
    super.key,
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
    var crossAxisCount = 2;
    if (screenWidth > 2400) {
      crossAxisCount = 8;
    }
    if (screenWidth <= 2400) {
      crossAxisCount = 5;
    }
    if (screenWidth <= 1920) {
      crossAxisCount = 3;
    }
    if (screenWidth <= 800) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      itemCount: comics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        return GridBoxDecoratedCell(
          index: index,
          gridViewCrossAxisCount: crossAxisCount,
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
    required this.index,
    required this.comic,
    super.key,
  });

  final int index;
  final Comic comic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: index.isEven ? AppColors.lightGrey : AppColors.grey,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push<void>(
            ComicDetailPage.page(comic),
          );
        },
        splashColor: AppColors.blue,
        highlightColor: AppColors.lightBlue,
        child: SizedBox(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: MarvelNetworkImage(
                  imageUrl: comic.thumbnail.comicHomePreview,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: AppColors.blue.withOpacity(0.4),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    comic.title,
                    style: theme.textTheme.bodyMedium,
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
