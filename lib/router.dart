import 'package:flutter/material.dart';
import 'package:marvel/ui/hero_detail_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HeroDetailScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => HeroDetailScreen(),
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
