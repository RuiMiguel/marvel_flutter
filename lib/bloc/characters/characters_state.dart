part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState([List props = const []]);

  @override
  List<Object> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersSuccess extends CharactersState {
  final List<Character> characters;
  final int count;
  final int total;
  final String legal;

  CharactersSuccess(
      {required this.characters,
      required this.count,
      required this.total,
      required this.legal})
      : super([characters, count, total, legal]);
}

class CharactersError extends CharactersState {
  final Failure error;

  CharactersError(this.error) : super([error]);
}
