import 'package:flutter/material.dart';
import 'package:marvel/core/base/result.dart';
import 'package:marvel/core/controllers/characters_controller.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/ui/characters/home_grid.dart';
import 'package:marvel/ui/characters/home_list.dart';
import 'package:marvel/ui/commons/error_view.dart';
import 'package:marvel/ui/commons/legal_info.dart';
import 'package:marvel/ui/commons/loading_view.dart';
import 'package:provider/provider.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<CharactersController>();

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
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
                if (controller.characters is Loading) {
                  return LoadingView();
                } else if (controller.characters is Error) {
                  return ErrorView();
                } else if (controller.characters is Success<List<Character>>) {
                  if (orientation == Orientation.landscape) {
                    return HomeGridView(
                      characters: (controller.characters as Success).data,
                    );
                  } else {
                    return HomeListView(
                      characters: (controller.characters as Success).data,
                    );
                  }
                } else {
                  return ErrorView();
                }
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
