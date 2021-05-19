import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel/bloc/authentication/authentication_bloc.dart' as Auth;
import 'package:marvel_data/marvel_data.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late String _privateKey;
  late String _publicKey;

  final DatastoreManager datastore;
  final Auth.AuthenticationBloc authenticationBloc;

  LoginBloc({required this.authenticationBloc, required this.datastore})
      : super(LoginInitial());

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SetPrivateKey) {
      _privateKey = event.privateKey;
    } else if (event is SetPublicKey) {
      _publicKey = event.publicKey;
    } else if (event is Login) {
      yield Loading();
      Future.delayed(Duration(seconds: 3));
      authenticationBloc.add(Auth.Authenticate(_privateKey, _publicKey));
    } else if (event is Logout) {
      authenticationBloc.add(Auth.UnAuthenticate());
      yield LoggedOut();
    }
  }
}
