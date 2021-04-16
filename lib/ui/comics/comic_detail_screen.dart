import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';

class ComicDetailScreen extends StatelessWidget {
  static const String routeName = "comic-details/";

  final Comic comic;

  const ComicDetailScreen({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(
        color: Section.comics.color, brightness: Brightness.light);

    return Container(
      color: Section.comics.color,
    );
  }
}
