import 'package:flutter/material.dart';
import 'home_list_element.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 2),
      itemBuilder: (context, index) {
        return HomeListElement(index: index);
      },
    );
  }
}
