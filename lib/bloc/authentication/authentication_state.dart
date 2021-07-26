part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class UnInitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  const Authenticated({required this.privateKey, required this.publicKey})
      : super();

  final String privateKey;
  final String publicKey;

  @override
  List<Object> get props => [privateKey, publicKey];
}

class AuthenticationFailed extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}
