import 'package:flutter/material.dart';
import '../hero_detail_screen.dart';

class HomeListElement extends StatelessWidget {
  const HomeListElement({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index % 2 == 1 ? Colors.grey[300] : Colors.grey[500],
      child: InkWell(
        child: Center(
          child: Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.contain,
            height: 150,
          ),
        ),
        splashColor: Colors.red[500],
        highlightColor: Colors.red[300],
        onTap: () {
          Navigator.of(context).pushNamed(
            HeroDetailScreen.routeName,
          );
        },
      ),
    );
  }
}
