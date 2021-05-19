part of 'comics_bloc.dart';

abstract class ComicsState extends Equatable {
  const ComicsState([List props = const []]);

  @override
  List<Object> get props => [];
}

class ComicsInitial extends ComicsState {}

class Loading extends ComicsState {}

class Success extends ComicsState {
  final List<Comic> comics;
  final int count;
  final int total;
  final String legal;

  Success(
      {required this.comics,
      required this.count,
      required this.total,
      required this.legal})
      : super([comics, count, total, legal]);
}

class Error extends ComicsState {
  final Failure error;

  Error(this.error) : super([error]);
}
