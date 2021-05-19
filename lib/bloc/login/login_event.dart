part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class SetPrivateKey extends LoginEvent {
  final String privateKey;

  SetPrivateKey(this.privateKey) : super([privateKey]);

  @override
  String toString() => "SetPrivateKey privateKey: $privateKey";
}

class SetPublicKey extends LoginEvent {
  final String publicKey;

  SetPublicKey(this.publicKey) : super([publicKey]);

  @override
  String toString() => "SetPublicKey publicKey: $publicKey";
}

class Login extends LoginEvent {}

class Logout extends LoginEvent {}

class LoginSuccess extends LoginEvent {}

class LoginFailure extends LoginEvent {}
