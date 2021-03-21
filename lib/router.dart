import 'package:flutter/material.dart';
import 'package:marvel/ui/characters/character_detail_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CharacterDetailScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => CharacterDetailScreen(),
      );
      break;

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
