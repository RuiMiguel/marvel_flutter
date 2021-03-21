import 'package:flutter/material.dart';
import 'home_list_element.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return HomeListElement(index: index);
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
