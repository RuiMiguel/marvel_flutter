part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent() : super();

  @override
  List<Object> get props => [];
}

class HasAuthenticated extends AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {
  Authenticate(this.privateKey, this.publicKey) : super();

  final String privateKey;
  final String publicKey;

  @override
  String toString() =>
      'Authenticate {privateKey: $privateKey, publicKey: $publicKey}';
}

class UnAuthenticate extends AuthenticationEvent {}
