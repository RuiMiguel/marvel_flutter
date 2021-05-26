part of 'comics_bloc.dart';

abstract class ComicsState extends Equatable {
  const ComicsState([List props = const []]);

  @override
  List<Object> get props => [];
}

class ComicsInitial extends ComicsState {}

class ComicsLoading extends ComicsState {}

class ComicsSuccess extends ComicsState {
  final List<Comic> comics;
  final int count;
  final int total;
  final String legal;

  ComicsSuccess(
      {required this.comics,
      required this.count,
      required this.total,
      required this.legal})
      : super([comics, count, total, legal]);
}

class ComicsError extends ComicsState {
  final Failure error;

  ComicsError(this.error) : super([error]);
}
