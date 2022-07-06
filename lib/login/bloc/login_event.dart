part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent() : super();

  @override
  List<Object?> get props => [];
}

class SetPrivateKey extends LoginEvent {
  const SetPrivateKey(this.privateKey) : super();

  final String privateKey;

  @override
  List<Object> get props => [privateKey];
}

class SetPublicKey extends LoginEvent {
  const SetPublicKey(this.publicKey) : super();

  final String publicKey;

  @override
  List<Object> get props => [publicKey];
}

class Login extends LoginEvent {}

class Logout extends LoginEvent {}

class LoginSuccess extends LoginEvent {}

class LoginFailure extends LoginEvent {}
