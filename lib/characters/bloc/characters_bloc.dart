import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_domain/marvel_domain.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  int _limit = 50;
  int _offset = 0;
  int total = 0;
  int count = 0;
  List<Character> _characters = List.empty(growable: true);
  String legal = "";

  final CharactersRepository _charactersRepository;

  CharactersBloc(this._charactersRepository) : super(CharactersInitial());

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is LoadCharacters) {
      yield CharactersLoading();

      var result =
          await _charactersRepository.getCharactersResult(_limit, _offset);

      result.fold(
        (failure) {
          add(LoadCharactersError(failure));
        },
        (success) {
          add(LoadCharactersSuccess(success));
        },
      );
    } else if (event is GetMore) {
      yield CharactersLoading();

      _offset = _offset + _limit;

      var result =
          await _charactersRepository.getCharactersResult(_limit, _offset);
      result.fold(
        (failure) {
          add(LoadCharactersError(failure));
        },
        (success) {
          add(LoadMoreCharactersSuccess(success));
        },
      );
    } else if (event is LoadCharactersError) {
      yield CharactersError(event.error);
    } else if (event is LoadCharactersSuccess) {
      _characters = event.characters.data.results;

      total = event.characters.data.total;
      count = event.characters.data.offset + event.characters.data.count;
      legal = event.characters.attributionText;
      yield CharactersSuccess(
        characters: _characters,
        count: count,
        total: total,
        legal: legal,
      );
    } else if (event is LoadMoreCharactersSuccess) {
      _characters.addAll(event.characters.data.results);

      count = event.characters.data.offset + event.characters.data.count;
      yield CharactersSuccess(
        characters: _characters,
        count: count,
        total: total,
        legal: legal,
      );
    }
  }
}
