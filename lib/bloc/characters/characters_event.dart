part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharactersEvent {}

class GetMore extends CharactersEvent {}
