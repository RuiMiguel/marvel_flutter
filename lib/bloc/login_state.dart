part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState([List props = const []]);

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class LoggedIn extends LoginState {}

class LoginFailed extends LoginState {}

class LoggedOut extends LoginState {}
