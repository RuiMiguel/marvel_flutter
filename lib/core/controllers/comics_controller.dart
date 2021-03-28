import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/data/repository/comics_repository.dart';

class ComicsController extends ChangeNotifier {
  final ComicsRepository _comicsRepository;

  var comics = List<Comic>.empty();

  ComicsController(this._comicsRepository) {
    getComics();
  }

  Future<void> getComics() async {
    comics = await _comicsRepository.getComics();
    notifyListeners();
  }
}
