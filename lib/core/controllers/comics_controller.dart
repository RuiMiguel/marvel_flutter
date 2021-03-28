import 'package:flutter/material.dart';
import 'package:marvel/core/model/comic.dart';

class ComicsController extends ChangeNotifier {
  var comics = List<Comic>.empty();

  ComicsController() {
    getComics();
  }

  Future<void> getComics() async {
    comics = List.empty();
    notifyListeners();
  }
}
