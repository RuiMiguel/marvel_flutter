import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/data/repository/characters_repository.dart';

class CharactersController extends ChangeNotifier {
  final CharactersRepository _charactersRepository;

  var characters = List<Character>.empty();

  CharactersController(this._charactersRepository) {
    getCharacters();
  }

  Future<void> getCharacters() async {
    characters = await _charactersRepository.getCharacters();
    notifyListeners();
  }
}
