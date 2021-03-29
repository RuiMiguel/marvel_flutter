import 'package:flutter/material.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/data/repository/characters_repository.dart';

class CharactersController extends ChangeNotifier {
  final CharactersRepository _charactersRepository;

  int _limit = 50;
  int _offset = 0;
  List<Character> characters = List.empty();
  String legal = "";

  CharactersController(this._charactersRepository) {
    getCharactersResult();
  }

  Future<void> getMore() async {
    _offset = _offset + _limit;
    var moreResults =
        await _charactersRepository.getCharactersResult(_limit, _offset);
    characters.addAll(moreResults.data.results);
    notifyListeners();
  }

  Future<void> getCharactersResult() async {
    var results =
        await _charactersRepository.getCharactersResult(_limit, _offset);
    characters = results.data.results;
    legal = results.attributionText;
    notifyListeners();
  }
}
