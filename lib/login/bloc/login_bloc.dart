import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authenticationRepository,
  }) : super(LoginState()) {
    on<PrivateKeySetted>(_onSetPrivateKey);
    on<PublicKeySetted>(_onSetPublicKey);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  final AuthenticationRepository authenticationRepository;

  Future<void> _onSetPrivateKey(
    PrivateKeySetted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(privateKey: event.privateKey));
  }

  Future<void> _onSetPublicKey(
    PublicKeySetted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(publicKey: event.publicKey));
  }

  Future<void> _onLogin(
    Login event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    await authenticationRepository.login(
      privateKey: state.privateKey,
      publicKey: state.publicKey,
    );

    emit(state.copyWith(status: LoginStatus.success));
  }

  Future<void> _onLogout(
    Logout event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    await authenticationRepository.logout();

    emit(
      state.copyWith(
        status: LoginStatus.success,
        privateKey: '',
        publicKey: '',
      ),
    );
  }
}
