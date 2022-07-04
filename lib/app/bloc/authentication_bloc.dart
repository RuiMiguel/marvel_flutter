import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.authenticationRepository})
      : super(const AuthenticationState.initial()) {
    on<CredentialsChanged>(onCredentialsChanged);

    authenticationRepository.credentials.distinct().listen(_credentialsChanged);
  }

  final AuthenticationRepository authenticationRepository;

  void _credentialsChanged(bool event) =>
      add(CredentialsChanged(authenticated: event));

  void onCredentialsChanged(
    CredentialsChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(status: AuthenticationStatus.authenticated));
  }
}
