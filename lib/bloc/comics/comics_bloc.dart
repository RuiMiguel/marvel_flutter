import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_domain/marvel_domain.dart';

part 'comics_event.dart';
part 'comics_state.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  int _limit = 50;
  int _offset = 0;
  int total = 0;
  int count = 0;
  List<Comic> _comics = List.empty(growable: true);
  String legal = "";

  final ComicsRepository _comicsRepository;

  ComicsBloc(this._comicsRepository) : super(ComicsInitial());

  @override
  Stream<ComicsState> mapEventToState(
    ComicsEvent event,
  ) async* {
    if (event is LoadComics) {
      yield ComicsLoading();

      var result = await _comicsRepository.getComicsResult(_limit, _offset);
      result.fold(
        (failure) {
          add(LoadComicsError(failure));
        },
        (success) {
          add(LoadComicsSuccess(success));
        },
      );
    } else if (event is GetMore) {
      yield ComicsLoading();

      _offset = _offset + _limit;

      var result = await _comicsRepository.getComicsResult(_limit, _offset);
      result.fold(
        (failure) {
          add(LoadComicsError(failure));
        },
        (success) {
          add(LoadMoreComicsSuccess(success));
        },
      );
    } else if (event is LoadComicsError) {
      yield ComicsError(event.error);
    } else if (event is LoadComicsSuccess) {
      _comics = event.comics.data.results;

      total = event.comics.data.total;
      count = event.comics.data.offset + event.comics.data.count;
      legal = event.comics.attributionText;
      yield ComicsSuccess(
        comics: _comics,
        count: count,
        total: total,
        legal: legal,
      );
    } else if (event is LoadMoreComicsSuccess) {
      _comics.addAll(event.comics.data.results);

      count = event.comics.data.offset + event.comics.data.count;
      yield ComicsSuccess(
        comics: _comics,
        count: count,
        total: total,
        legal: legal,
      );
    }
  }
}
