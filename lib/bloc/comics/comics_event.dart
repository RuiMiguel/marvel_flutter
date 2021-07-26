part of 'comics_bloc.dart';

abstract class ComicsEvent extends Equatable {
  const ComicsEvent() : super();

  @override
  List<Object> get props => [];
}

class LoadComics extends ComicsEvent {}

class GetMore extends ComicsEvent {}

class LoadComicsError extends ComicsEvent {
  const LoadComicsError(this.error) : super();
  final Failure error;
}

class LoadComicsSuccess extends ComicsEvent {
  const LoadComicsSuccess(this.comics) : super();

  final DataResult<Comic> comics;
}

class LoadMoreComicsSuccess extends ComicsEvent {
  const LoadMoreComicsSuccess(this.comics) : super();

  final DataResult<Comic> comics;
}
