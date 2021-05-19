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
      yield Loading();

      var result = await _comicsRepository.getComicsResult(_limit, _offset);
      result.fold(
        (failure) async* {
          yield Error(failure);
        },
        (success) async* {
          _comics = success.data.results;

          total = success.data.total;
          count = success.data.offset + success.data.count;
          legal = success.attributionText;
          yield Success(
            comics: _comics,
            count: count,
            total: total,
            legal: legal,
          );
        },
      );
    } else if (event is GetMore) {
      yield Loading();

      _offset = _offset + _limit;

      var result = await _comicsRepository.getComicsResult(_limit, _offset);
      result.fold(
        (failure) async* {
          yield Error(failure);
        },
        (success) async* {
          _comics.addAll(success.data.results);

          count = success.data.offset + success.data.count;
          yield Success(
            comics: _comics,
            count: count,
            total: total,
            legal: legal,
          );
        },
      );
    }
  }
}
