import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const String routeName = "character-details/";

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(
        color: Section.characters.color, brightness: Brightness.light);

    return Container(color: Section.characters.color);
  }
}
