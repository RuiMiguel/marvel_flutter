import 'package:flutter/material.dart';
import 'package:marvel/characters/ui/character_detail_screen.dart';
import 'package:marvel/ui/comics/comic_detail_screen.dart';
import 'package:marvel/ui/commons/webview_screen.dart';
import 'package:marvel/ui/login/login_screen.dart';
import 'package:marvel_domain/marvel_domain.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => LoginScreen(),
      );
    case CharacterDetailScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => CharacterDetailScreen(
          character: settings.arguments as Character,
        ),
      );
    case ComicDetailScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => ComicDetailScreen(
          comic: settings.arguments as Comic,
        ),
      );
    case WebViewScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => WebViewScreen(
          url: settings.arguments as String,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Route not found'),
          ),
        ),
      );
  }
}
