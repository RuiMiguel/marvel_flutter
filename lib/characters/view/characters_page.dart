import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_repository/character_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/characters/characters.dart';
import 'package:marvel/characters/widget/widget.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/widget/widget.dart';
import 'package:marvel/styles/styles.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(
        characterRepository: context.read<CharacterRepository>(),
      )..add(CharactersLoaded()),
      child: const CharactersView(),
    );
  }
}

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bloc = context.read<CharactersBloc>();

    return BlocConsumer<CharactersBloc, CharactersState>(
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
              bloc.add(CharactersGotMore());
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
                    CharactersViewContent(characters: state.characters),
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
class CharactersViewContent extends StatelessWidget {
  const CharactersViewContent({
    super.key,
    required this.characters,
  });

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return (orientation == Orientation.landscape)
            ? _CharactersGridView(
                characters: characters,
              )
            : _CharactersListView(
                characters: characters,
              );
      },
    );
  }
}

class _CharactersGridView extends StatelessWidget {
  const _CharactersGridView({
    super.key,
    required this.characters,
  });

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 3;
    if (screenWidth > 2400) {
      _crossAxisCount = 15;
    }
    if (screenWidth <= 2400) {
      _crossAxisCount = 10;
    }
    if (screenWidth <= 1920) {
      _crossAxisCount = 5;
    }
    if (screenWidth <= 800) {
      _crossAxisCount = 3;
    }

    return GridView.builder(
      itemCount: characters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount,
      ),
      itemBuilder: (context, index) {
        return _CharacterElement(
          index: index,
          character: characters[index],
        );
      },
    );
  }
}

class _CharactersListView extends StatelessWidget {
  const _CharactersListView({
    super.key,
    required this.characters,
  });

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return CharacterElement(
          index: index,
          character: characters[index],
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.black,
          height: 2,
        );
      },
    );
  }
}

@visibleForTesting
class CharacterElement extends StatelessWidget {
  const CharacterElement({
    super.key,
    required this.index,
    required this.character,
  });

  final int index;
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index.isEven ? lightGrey : grey,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push<void>(
            CharacterDetailPage.page(character),
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
                  imageUrl:
                      '${character.thumbnail.path}/landscape_amazing.${character.thumbnail.extension}',
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
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          Image.asset(
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
                  color: blue.withOpacity(0.4),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    character.name,
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
