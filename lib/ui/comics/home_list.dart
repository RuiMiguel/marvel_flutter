import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/ui/comics/home_list_element.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({Key? key, required this.comics}) : super(key: key);

  final List<Comic> comics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: comics.length,
      itemBuilder: (context, index) {
        return HomeListElement(
          index: index,
          comic: comics[index],
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
