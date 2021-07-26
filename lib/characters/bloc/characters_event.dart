part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent() : super();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharactersEvent {}

class GetMore extends CharactersEvent {}

class LoadCharactersError extends CharactersEvent {
  const LoadCharactersError(this.error) : super();

  final Failure error;

  @override
  List<Object> get props => [error];
}

class LoadCharactersSuccess extends CharactersEvent {
  const LoadCharactersSuccess(this.characters) : super();

  final DataResult<Character> characters;

  @override
  List<Object> get props => [characters];
}

class LoadMoreCharactersSuccess extends CharactersEvent {
  const LoadMoreCharactersSuccess(this.characters) : super();

  final DataResult<Character> characters;

  @override
  List<Object> get props => [characters];
}
