part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState([List props = const []]);

  @override
  List<Object> get props => [];
}

class CharactersInitial extends CharactersState {}

class Loading extends CharactersState {}

class Success extends CharactersState {
  final List<Character> characters;
  final int count;
  final int total;
  final String legal;

  Success(
      {required this.characters,
      required this.count,
      required this.total,
      required this.legal})
      : super([characters, count, total, legal]);
}

class Error extends CharactersState {
  final Failure error;

  Error(this.error) : super([error]);
}
