import 'package:flutter/material.dart';
import 'package:marvel/ui/characters/character_detail_screen.dart';
import 'package:marvel/ui/comics/comic_detail_screen.dart';
import 'package:marvel/ui/login/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => LoginScreen(),
      );
    case CharacterDetailScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => CharacterDetailScreen(),
      );
    case ComicDetailScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => ComicDetailScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text("Route not found"),
          ),
        ),
      );
  }
}
