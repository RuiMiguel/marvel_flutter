part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  const AuthenticationState({required this.status});

  const AuthenticationState.initial()
      : status = AuthenticationStatus.unauthenticated;

  final AuthenticationStatus status;

  @override
  List<Object?> get props => [status];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
    );
  }
}
