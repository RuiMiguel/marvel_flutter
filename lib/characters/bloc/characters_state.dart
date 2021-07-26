part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersSuccess extends CharactersState {
  const CharactersSuccess({
    required this.characters,
    required this.count,
    required this.total,
    required this.legal,
  }) : super();

  final List<Character> characters;
  final int count;
  final int total;
  final String legal;

  @override
  List<Object> get props => [characters, count, total, legal];
}

class CharactersError extends CharactersState {
  const CharactersError(this.error) : super();

  final Failure error;

  @override
  List<Object> get props => [error];
}
