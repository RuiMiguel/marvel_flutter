part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState([List props = const []]);

  @override
  List<Object> get props => [];
}

class UnInitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String privateKey;
  final String publicKey;

  Authenticated({required this.privateKey, required this.publicKey})
      : super([privateKey, publicKey]);

  @override
  String toString() =>
      'Authenticated {privateKey: $privateKey, publicKey: $publicKey}';
}

class AuthenticationFailed extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}
