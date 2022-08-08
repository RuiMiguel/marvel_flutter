part of 'comics_bloc.dart';

abstract class ComicsEvent extends Equatable {
  const ComicsEvent() : super();

  @override
  List<Object> get props => [];
}

class ComicsLoaded extends ComicsEvent {}

class ComicsGotMore extends ComicsEvent {}
