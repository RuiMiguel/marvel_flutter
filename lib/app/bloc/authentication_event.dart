part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class CredentialsChanged extends AuthenticationEvent {
  const CredentialsChanged({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}
