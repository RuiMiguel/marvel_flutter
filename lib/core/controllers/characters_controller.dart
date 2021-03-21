import 'package:flutter/material.dart';
import 'package:marvel/core/model/Character.dart';

class CharactersController extends ChangeNotifier {
  var characters = List<Character>.empty();

  CharactersController() {
    getCharacters();
  }

  void getCharacters() {
    characters =
        List.generate(100, (index) => Character(title: "Heroe $index"));
    notifyListeners();
  }
}
