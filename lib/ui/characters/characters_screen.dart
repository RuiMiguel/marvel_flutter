import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/characters/characters_bloc.dart';
import 'package:marvel/ui/characters/home_grid.dart';
import 'package:marvel/ui/characters/home_list.dart';
import 'package:marvel/ui/commons/error_view.dart';
import 'package:marvel/ui/commons/legal_info.dart';
import 'package:marvel/ui/commons/loading_view.dart';
import 'package:marvel_domain/marvel_domain.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  _showData(CharactersState state, Orientation orientation) {
    List<Character>? data;

    if (state is CharactersSuccess) {
      data = state.characters;
    }

    if (orientation == Orientation.landscape) {
      return HomeGridView(
        characters: data,
      );
    } else {
      return HomeListView(
        characters: data,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CharactersBloc>(context);

    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        var legal = "";
        var count = 0;
        var total = 0;

        if (state is CharactersInitial) bloc.add(LoadCharacters());

        if (state is CharactersSuccess) {
          legal = state.legal;
          count = state.count;
          total = state.total;
        }

        if (state is CharactersError) {
          showDialog(
              context: context,
              builder: (context) {
                return ErrorView();
              });
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                (scrollNotification.metrics.pixels ==
                    scrollNotification.metrics.maxScrollExtent)) {
              bloc.add(GetMore());
              return true;
            }
            return false;
          },
          child: Column(
            children: [
              Expanded(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    return Stack(
                      children: [
                        _showData(state, orientation),
                        Visibility(
                          visible: state is CharactersLoading,
                          child: LoadingView(),
                        )
                      ],
                    );
                  },
                ),
              ),
              LegalInfo(
                legal: legal,
                count: count,
                total: total,
              ),
            ],
          ),
        );
      },
    );
  }
}
