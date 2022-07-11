part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  const AuthenticationState({required this.status, required this.user});

  const AuthenticationState.authenticated(User newUser)
      : status = AuthenticationStatus.authenticated,
        user = newUser;

  const AuthenticationState.unauthenticated()
      : status = AuthenticationStatus.unauthenticated,
        user = const User.anonymous();

  final AuthenticationStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
