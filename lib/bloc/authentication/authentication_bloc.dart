import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_data/marvel_data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.datastore) : super(UnInitialized());

  final DatastoreManager datastore;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is HasAuthenticated) {
      var privateKey = datastore.getPrivateKey();
      var publicKey = datastore.getPublicKey();
      var logged = (privateKey.isNotEmpty && publicKey.isNotEmpty);
      if (logged) {
        yield Authenticated(privateKey: privateKey, publicKey: publicKey);
      } else {
        yield UnAuthenticated();
      }
    } else if (event is Authenticate) {
      var privateKeySaved = await datastore.setPrivateKey(event.privateKey);
      var publicKeySaved = await datastore.setPublicKey(event.publicKey);
      var logged = (privateKeySaved && publicKeySaved);
      if (logged) {
        yield Authenticated(
            privateKey: event.privateKey, publicKey: event.publicKey);
      } else {
        yield AuthenticationFailed();
      }
    } else if (event is UnAuthenticate) {
      await datastore.clearPrivateKey();
      await datastore.clearPublicKey();
      yield UnAuthenticated();
    }
  }
}
