import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/data/repository/comics_repository.dart';

class ComicsController extends ChangeNotifier {
  final ComicsRepository _comicsRepository;

  int _limit = 50;
  int _offset = 0;
  List<Comic> comics = List.empty();
  String legal = "";

  ComicsController(this._comicsRepository) {
    getComicsResult();
  }

  Future<void> getMore() async {
    _offset = _offset + _limit;
    var moreResults = await _comicsRepository.getComicsResult(_limit, _offset);
    comics.addAll(moreResults.data.results);
    notifyListeners();
  }

  Future<void> getComicsResult() async {
    var results = await _comicsRepository.getComicsResult(_limit, _offset);
    comics = results.data.results;
    legal = results.attributionText;
    notifyListeners();
  }
}
