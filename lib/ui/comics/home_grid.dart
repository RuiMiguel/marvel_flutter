import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/ui/comics/home_grid_element.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({Key? key, required this.comics}) : super(key: key);

  final List<Comic> comics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: comics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1),
      itemBuilder: (context, index) {
        return HomeGridElement(
          index: index,
          comic: comics[index],
        );
      },
    );
  }
}
