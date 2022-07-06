import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auto_login_event.dart';
part 'auto_login_state.dart';

class AutoLoginBloc extends Bloc<AutoLoginEvent, AutoLoginState> {
  AutoLoginBloc({required this.authenticationRepository})
      : super(const AutoLoginState.initial()) {
    on<AutoLogin>(onAutoLogin);
  }

  final AuthenticationRepository authenticationRepository;

  Future<void> onAutoLogin(
    AutoLogin event,
    Emitter<AutoLoginState> emit,
  ) async {
    String privateKey;
    String publicKey;

    try {
      emit(state.copyWith(status: AutoLoginStatus.loading));

      privateKey = await authenticationRepository.privateKey();
      publicKey = await authenticationRepository.publicKey();

      await authenticationRepository.login(
        privateKey: privateKey,
        publicKey: publicKey,
      );

      emit(state.copyWith(status: AutoLoginStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      await authenticationRepository.logout();
      emit(state.copyWith(status: AutoLoginStatus.error));
    }
  }
}
