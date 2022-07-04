part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CredentialsChanged extends AuthenticationEvent {
  const CredentialsChanged({required this.authenticated});

  final bool authenticated;

  @override
  List<Object> get props => [authenticated];
}
