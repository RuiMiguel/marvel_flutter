import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/comics_controller.dart';
import 'package:marvel/ui/comics/home_grid.dart';
import 'package:marvel/ui/comics/home_list.dart';
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
                if (orientation == Orientation.landscape) {
                  return HomeListView(
                    comics: controller.comics,
                  );
                } else {
                  return HomeGridView(
                    comics: controller.comics,
                  );
                }
              },
            ),
          ),
          Text(controller.legal),
        ],
      ),
    );
  }
}
