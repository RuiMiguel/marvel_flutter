import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:character_repository/character_repository.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({
    required this.characterRepository,
  }) : super(const CharactersState.initial()) {
    on<CharactersLoaded>(_onCharactersLoaded);
    on<CharactersGotMore>(_onCharactersGotMore);
  }

  final CharacterRepository characterRepository;

  Future<void> _onCharactersLoaded(
    CharactersLoaded event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CharactersStatus.loading));

      final dataResult = await characterRepository.getCharactersResult(
        limit: 50,
        offset: 0,
      );

      emit(
        state.copyWith(
          status: CharactersStatus.success,
          characters: dataResult.data.results,
          count: dataResult.data.count,
          total: dataResult.data.total,
          offset: dataResult.data.offset,
          legal: dataResult.attributionText,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: CharactersStatus.error));
    }
  }

  Future<void> _onCharactersGotMore(
    CharactersGotMore event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CharactersStatus.loading));

      final _offset = state.offset + 50;
      final dataResult = await characterRepository.getCharactersResult(
        limit: 50,
        offset: _offset,
      );

      emit(
        state.copyWith(
          status: CharactersStatus.success,
          characters: [...state.characters, ...dataResult.data.results],
          count: dataResult.data.offset + dataResult.data.count,
          total: dataResult.data.total,
          offset: dataResult.data.offset,
          legal: dataResult.attributionText,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: CharactersStatus.error));
    }
  }
}
