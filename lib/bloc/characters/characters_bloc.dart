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
      yield Loading();

      var result =
          await _charactersRepository.getCharactersResult(_limit, _offset);
      result.fold(
        (failure) async* {
          yield Error(failure);
        },
        (success) async* {
          _characters = success.data.results;

          total = success.data.total;
          count = success.data.offset + success.data.count;
          legal = success.attributionText;
          yield Success(
            characters: _characters,
            count: count,
            total: total,
            legal: legal,
          );
        },
      );
    } else if (event is GetMore) {
      yield Loading();

      _offset = _offset + _limit;

      var result =
          await _charactersRepository.getCharactersResult(_limit, _offset);
      result.fold(
        (failure) async* {
          yield Error(failure);
        },
        (success) async* {
          _characters.addAll(success.data.results);

          count = success.data.offset + success.data.count;
          yield Success(
            characters: _characters,
            count: count,
            total: total,
            legal: legal,
          );
        },
      );
    }
  }
}
