import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(const AuthenticationState.unauthenticated()) {
    on<CredentialsChanged>(onCredentialsChanged);

    _authenticationSubscription =
        authenticationRepository.user.listen(_credentialsChanged);
  }

  final AuthenticationRepository authenticationRepository;
  late StreamSubscription _authenticationSubscription;

  void _credentialsChanged(User user) {
    add(CredentialsChanged(user: user));
  }

  Future<void> onCredentialsChanged(
    CredentialsChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = event.user;

    emit(
      user != const User.anonymous()
          ? AuthenticationState.authenticated(user)
          : const AuthenticationState.unauthenticated(),
    );
  }

  @override
  Future<void> close() {
    _authenticationSubscription.cancel();
    return super.close();
  }
}
