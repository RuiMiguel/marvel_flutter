part of 'comics_bloc.dart';

abstract class ComicsEvent extends Equatable {
  const ComicsEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadComics extends ComicsEvent {}

class GetMore extends ComicsEvent {}
