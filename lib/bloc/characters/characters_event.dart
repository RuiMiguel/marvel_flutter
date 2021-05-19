part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharactersEvent {}

class GetMore extends CharactersEvent {}

class LoadCharactersError extends CharactersEvent {
  final Failure error;

  LoadCharactersError(this.error) : super([error]);
}

class LoadCharactersSuccess extends CharactersEvent {
  final DataResult<Character> characters;

  LoadCharactersSuccess(this.characters) : super([characters]);
}

class LoadMoreCharactersSuccess extends CharactersEvent {
  final DataResult<Character> characters;

  LoadMoreCharactersSuccess(this.characters) : super([characters]);
}
