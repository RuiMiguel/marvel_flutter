import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel/bloc/authentication/authentication_bloc.dart' as auth;
import 'package:marvel_data/marvel_data.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authenticationBloc, required this.datastore})
      : super(LoginInitial());

  final DatastoreManager datastore;
  final auth.AuthenticationBloc authenticationBloc;

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SetPrivateKey) {
      state.privateKey = event.privateKey;
    } else if (event is SetPublicKey) {
      state.publicKey = event.publicKey;
    } else if (event is Login) {
      yield Loading(state.privateKey, state.publicKey);
      await Future.delayed(const Duration(seconds: 3));
      authenticationBloc
          .add(auth.Authenticate(state.privateKey, state.publicKey));
    } else if (event is Logout) {
      authenticationBloc.add(auth.UnAuthenticate());
      yield LoggedOut();
    }
  }
}
