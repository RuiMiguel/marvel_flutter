import 'package:core_domain/core_domain.dart';
import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/comics_controller.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/ui/comics/home_grid.dart';
import 'package:marvel/ui/comics/home_list.dart';
import 'package:marvel/ui/commons/error_view.dart';
import 'package:marvel/ui/commons/legal_info.dart';
import 'package:marvel/ui/commons/loading_view.dart';
import 'package:provider/provider.dart';

class ComicsScreen extends StatelessWidget {
  const ComicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ComicsController>();

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
                if (controller.comics is Loading) {
                  return LoadingView();
                } else if (controller.comics is Error) {
                  return ErrorView();
                } else if (controller.comics is Success<List<Comic>>) {
                  if (orientation == Orientation.landscape) {
                    return HomeListView(
                      comics: (controller.comics as Success).data,
                    );
                  } else {
                    return HomeGridView(
                      comics: (controller.comics as Success).data,
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
