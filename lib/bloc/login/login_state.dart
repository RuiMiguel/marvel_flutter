part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  LoginState({required this.privateKey, required this.publicKey});

  String privateKey;
  String publicKey;

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  LoginInitial() : super(privateKey: '', publicKey: '');
}

class Loading extends LoginState {
  Loading(privateKey, publicKey)
      : super(privateKey: privateKey, publicKey: publicKey);
}

class LoginFailed extends LoginState {
  LoginFailed() : super(privateKey: '', publicKey: '');
}

class LoggedOut extends LoginState {
  LoggedOut() : super(privateKey: '', publicKey: '');
}
