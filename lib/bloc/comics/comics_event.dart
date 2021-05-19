part of 'comics_bloc.dart';

abstract class ComicsEvent extends Equatable {
  const ComicsEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadComics extends ComicsEvent {}

class GetMore extends ComicsEvent {}

class LoadComicsError extends ComicsEvent {
  final Failure error;

  LoadComicsError(this.error) : super([error]);
}

class LoadComicsSuccess extends ComicsEvent {
  final DataResult<Comic> comics;

  LoadComicsSuccess(this.comics) : super([comics]);
}

class LoadMoreComicsSuccess extends ComicsEvent {
  final DataResult<Comic> comics;

  LoadMoreComicsSuccess(this.comics) : super([comics]);
}
