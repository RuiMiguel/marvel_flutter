import 'package:flutter/material.dart';
import 'package:marvel_data/marvel_data.dart';

enum AuthStatus {
  UNINITIALIZED,
  AUTHENTICATED,
  UNAUTHENTICATED,
}

class LoginController extends ChangeNotifier {
  final DatastoreManager datastore;

  AuthStatus currentAuthStatus = AuthStatus.UNINITIALIZED;

  LoginController(this.datastore) {
    if (hasCredentials()) {
      currentAuthStatus = AuthStatus.AUTHENTICATED;
    } else {
      currentAuthStatus = AuthStatus.UNINITIALIZED;
    }
  }

  static const String PRIVATE_KEY = 'private_key';
  static const String PUBLICK_KEY = 'public_key';

  bool hasCredentials() {
    String privateKey = datastore.getPrivateKey();
    String publicKey = datastore.getPublicKey();
    return (privateKey.isNotEmpty && publicKey.isNotEmpty);
  }

  String getPrivateKey() {
    return datastore.getPrivateKey();
  }

  String getPublicKey() {
    return datastore.getPublicKey();
  }

  Future<bool> login(
      {required String privateKey, required String publicKey}) async {
    bool privateKeySaved = await datastore.setPrivateKey(privateKey);
    bool publicKeySaved = await datastore.setPublicKey(publicKey);

    var logged = (privateKeySaved && publicKeySaved);
    currentAuthStatus =
        (logged) ? AuthStatus.AUTHENTICATED : AuthStatus.UNAUTHENTICATED;
    notifyListeners();
    return logged;
  }

  Future<void> logout() async {
    await datastore.clearPrivateKey();
    await datastore.clearPublicKey();
    currentAuthStatus = AuthStatus.UNAUTHENTICATED;
    notifyListeners();
  }
}
