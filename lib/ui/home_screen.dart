import 'package:flutter/material.dart';
import 'package:marvel/ui/hero_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/placeholder.png',
              fit: BoxFit.contain,
              height: 120,
            ),
          ],
        ),
      ),
      body: HomeListView(),
    );
  }
}

class HomeListView extends StatelessWidget {
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

class HomeListElement extends StatelessWidget {
  const HomeListElement({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index % 2 == 1 ? Colors.grey[300] : Colors.grey[500],
      child: InkWell(
        child: Column(children: [
          Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.contain,
            height: 150,
          ),
        ]),
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
