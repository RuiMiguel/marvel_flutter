part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent() : super();

  @override
  List<Object> get props => [];
}

class CharactersLoaded extends CharactersEvent {}

class CharactersGotMore extends CharactersEvent {}
