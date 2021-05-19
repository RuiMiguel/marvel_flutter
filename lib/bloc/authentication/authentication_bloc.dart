import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_data/marvel_data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final DatastoreManager datastore;

  AuthenticationBloc(this.datastore) : super(UnInitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is HasAuthenticated) {
      String privateKey = datastore.getPrivateKey();
      String publicKey = datastore.getPublicKey();
      bool logged = (privateKey.isNotEmpty && publicKey.isNotEmpty);
      if (logged) {
        yield Authenticated(privateKey: privateKey, publicKey: publicKey);
      } else {
        yield UnAuthenticated();
      }
    } else if (event is Authenticate) {
      bool privateKeySaved = await datastore.setPrivateKey(event.privateKey);
      bool publicKeySaved = await datastore.setPublicKey(event.publicKey);
      bool logged = (privateKeySaved && publicKeySaved);
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
