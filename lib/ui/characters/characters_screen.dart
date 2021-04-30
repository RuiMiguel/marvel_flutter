import 'package:core_base/core_base.dart';
import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/characters_controller.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/ui/characters/home_grid.dart';
import 'package:marvel/ui/characters/home_list.dart';
import 'package:marvel/ui/commons/error_view.dart';
import 'package:marvel/ui/commons/legal_info.dart';
import 'package:marvel/ui/commons/loading_view.dart';
import 'package:provider/provider.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool _isLoading = false;

  _showLoading({bool loading = true}) {
    setState(() {
      _isLoading = loading;
    });
  }

  _showData(CharactersController controller, Orientation orientation) {
    List<Character>? data;

    if (controller.characters is Success<List<Character>>) {
      data = (controller.characters as Success).data;
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
    var controller = context.watch<CharactersController>();

    _showLoading(loading: controller.characters is Loading);

    if (controller.characters is Error) {
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
          controller.getMore();
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
                    _showData(controller, orientation),
                    Visibility(
                      visible: _isLoading,
                      child: LoadingView(),
                    )
                  ],
                );
              },
            ),
          ),
          LegalInfo(
            legal: controller.legal,
            count: controller.count,
            total: controller.total,
          ),
        ],
      ),
    );
  }
}
