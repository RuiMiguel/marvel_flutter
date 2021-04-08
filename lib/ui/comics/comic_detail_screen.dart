import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';

class ComicDetailScreen extends StatelessWidget {
  static const String routeName = "comic-details/";

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(
        color: Section.comics.color, brightness: Brightness.light);

    return Container(
      color: Section.comics.color,
    );
  }
}
