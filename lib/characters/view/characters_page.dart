import 'package:app_ui/app_ui.dart';
import 'package:character_repository/character_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:marvel/character_detail/character_detail.dart';
import 'package:marvel/characters/characters.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/widgets/widgets.dart';

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

@visibleForTesting
class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final bloc = context.read<CharactersBloc>();

    return BlocConsumer<CharactersBloc, CharactersState>(
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
class CharactersViewContent extends StatelessWidget {
  const CharactersViewContent({
    required this.characters,
    super.key,
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
  const _CharactersGridView({required this.characters});

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 3;
    if (screenWidth > 2400) {
      crossAxisCount = 15;
    }
    if (screenWidth <= 2400) {
      crossAxisCount = 10;
    }
    if (screenWidth <= 1920) {
      crossAxisCount = 5;
    }
    if (screenWidth <= 800) {
      crossAxisCount = 3;
    }

    return GridView.builder(
      itemCount: characters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      itemBuilder: (context, index) {
        return GridBoxDecoratedCell(
          index: index,
          gridViewCrossAxisCount: crossAxisCount,
          child: CharacterElement(
            index: index,
            character: characters[index],
          ),
        );
      },
    );
  }
}

class _CharactersListView extends StatelessWidget {
  const _CharactersListView({required this.characters});

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
          color: red,
          height: 1.5,
        );
      },
    );
  }
}

@visibleForTesting
class CharacterElement extends StatelessWidget {
  const CharacterElement({
    required this.index,
    required this.character,
    super.key,
  });

  final int index;
  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                child: MarvelNetworkImage(
                  imageUrl: character.thumbnail.characterHomePreview,
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
                    style: theme.textTheme.bodyText2,
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
