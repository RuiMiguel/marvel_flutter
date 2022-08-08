import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comic_repository/comic_repository.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'comics_event.dart';
part 'comics_state.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  ComicsBloc({
    required this.comicsRepository,
  }) : super(const ComicsState.initial()) {
    on<ComicsLoaded>(_onComicsLoaded);
    on<ComicsGotMore>(_onComicsGotMore);
  }

  final ComicRepository comicsRepository;

  Future<void> _onComicsLoaded(
    ComicsLoaded event,
    Emitter<ComicsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ComicsStatus.loading));

      final dataResult = await comicsRepository.getComicsResult(
        limit: 50,
        offset: 0,
      );

      emit(
        state.copyWith(
          status: ComicsStatus.success,
          comics: dataResult.data.results,
          count: dataResult.data.count,
          total: dataResult.data.total,
          offset: dataResult.data.offset,
          legal: dataResult.attributionText,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ComicsStatus.error));
    }
  }

  Future<void> _onComicsGotMore(
    ComicsGotMore event,
    Emitter<ComicsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ComicsStatus.loading));

      final _offset = state.offset + 50;
      final dataResult = await comicsRepository.getComicsResult(
        limit: 50,
        offset: _offset,
      );

      emit(
        state.copyWith(
          status: ComicsStatus.success,
          comics: [...state.comics, ...dataResult.data.results],
          count: dataResult.data.offset + dataResult.data.count,
          total: dataResult.data.total,
          offset: dataResult.data.offset,
          legal: dataResult.attributionText,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: ComicsStatus.error));
    }
  }
}
