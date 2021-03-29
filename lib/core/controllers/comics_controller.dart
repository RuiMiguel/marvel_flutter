import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/data/repository/comics_repository.dart';

class ComicsController extends ChangeNotifier {
  final ComicsRepository _comicsRepository;

  int _limit = 50;
  int _offset = 0;
  int total = 0;
  int count = 0;
  List<Comic> comics = List.empty();
  String legal = "";

  ComicsController(this._comicsRepository) {
    _loadComicsResult();
  }

  Future<void> _loadComicsResult() async {
    var results = await _comicsRepository.getComicsResult(_limit, _offset);
    total = results.data.total;
    count = results.data.count;
    comics = results.data.results;
    legal = results.attributionText;
    notifyListeners();
  }

  Future<void> getMore() async {
    _offset = _offset + _limit;
    var moreResults = await _comicsRepository.getComicsResult(_limit, _offset);
    count = moreResults.data.offset;
    comics.addAll(moreResults.data.results);
    notifyListeners();
  }
}
