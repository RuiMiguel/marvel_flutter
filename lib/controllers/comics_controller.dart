import 'package:core_domain/core_domain.dart';
import 'package:flutter/material.dart';
import 'package:marvel_domain/marvel_domain.dart';

class ComicsController extends ChangeNotifier {
  final ComicsRepository _comicsRepository;

  int _limit = 50;
  int _offset = 0;
  int total = 0;
  int count = 0;
  List<Comic> _comics = List.empty(growable: true);
  late Result comics;
  String legal = "";

  ComicsController(this._comicsRepository);

  Future<void> loadComicsResult() async {
    comics = Result.loading();
    notifyListeners();

    var results = await _comicsRepository.getComicsResult(_limit, _offset);
    results.fold(
      (failure) {
        comics = Result.error(failure);
        notifyListeners();
      },
      (success) {
        _comics = success.data.results;

        total = success.data.total;
        count = success.data.offset + success.data.count;
        comics = Result.success(_comics);
        legal = success.attributionText;
        notifyListeners();
      },
    );
  }

  Future<void> getMore() async {
    comics = Result.loading();
    notifyListeners();

    _offset = _offset + _limit;
    var moreResults = await _comicsRepository.getComicsResult(_limit, _offset);
    moreResults.fold(
      (failure) {
        comics = Result.error(failure);
        notifyListeners();
      },
      (success) {
        _comics.addAll(success.data.results);

        count = success.data.offset + success.data.count;
        comics = Result.success(_comics);
        notifyListeners();
      },
    );
  }
}
