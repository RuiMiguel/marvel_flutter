part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent() : super();

  @override
  List<Object?> get props => [];
}

class PrivateKeySetted extends LoginEvent {
  const PrivateKeySetted(this.privateKey) : super();

  final String privateKey;

  @override
  List<Object> get props => [privateKey];
}

class PublicKeySetted extends LoginEvent {
  const PublicKeySetted(this.publicKey) : super();

  final String publicKey;

  @override
  List<Object> get props => [publicKey];
}

class Login extends LoginEvent {}

class Logout extends LoginEvent {}

class LoginSuccess extends LoginEvent {}

class LoginFailure extends LoginEvent {}
