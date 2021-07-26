part of 'comics_bloc.dart';

abstract class ComicsState extends Equatable {
  const ComicsState();

  @override
  List<Object> get props => [];
}

class ComicsInitial extends ComicsState {}

class ComicsLoading extends ComicsState {}

class ComicsSuccess extends ComicsState {
  const ComicsSuccess({
    required this.comics,
    required this.count,
    required this.total,
    required this.legal,
  }) : super();

  final List<Comic> comics;
  final int count;
  final int total;
  final String legal;

  @override
  List<Object> get props => [comics, count, total, legal];
}

class ComicsError extends ComicsState {
  const ComicsError(this.error) : super();

  final Failure error;

  @override
  List<Object> get props => [error];
}
