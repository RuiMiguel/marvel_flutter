import 'package:core_domain/core_domain.dart';
import 'package:flutter/material.dart';
import 'package:marvel_domain/marvel_domain.dart';

class CharactersController extends ChangeNotifier {
  final CharactersRepository _charactersRepository;

  bool _initialized = false;

  int _limit = 50;
  int _offset = 0;
  int total = 0;
  int count = 0;
  List<Character> _characters = List.empty(growable: true);
  late Result characters;
  String legal = "";

  CharactersController(this._charactersRepository);

  Future<void> loadCharactersResult() async {
    if (!_initialized) {
      _loadCharactersResult();
      _initialized = true;
    }
  }

  Future<void> _loadCharactersResult() async {
    characters = Result.loading();
    notifyListeners();

    var results =
        await _charactersRepository.getCharactersResult(_limit, _offset);
    results.fold(
      (failure) {
        characters = Result.error(failure);
        notifyListeners();
      },
      (success) {
        _characters = success.data.results;

        total = success.data.total;
        count = success.data.offset + success.data.count;
        characters = Result.success(_characters);
        legal = success.attributionText;
        notifyListeners();
      },
    );
  }

  Future<void> getMore() async {
    characters = Result.loading();
    notifyListeners();

    _offset = _offset + _limit;
    var moreResults =
        await _charactersRepository.getCharactersResult(_limit, _offset);

    moreResults.fold(
      (failure) {
        characters = Result.error(failure);
        notifyListeners();
      },
      (success) {
        _characters.addAll(success.data.results);

        count = success.data.offset + success.data.count;
        characters = Result.success(_characters);
        notifyListeners();
      },
    );
  }
}
