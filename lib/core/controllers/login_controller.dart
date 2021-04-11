import 'package:flutter/material.dart';
import 'package:marvel/data/datastore_manager.dart';

enum AuthStatus {
  UNINITIALIZED,
  AUTHENTICATED,
  UNAUTHENTICATED,
}

class LoginController extends ChangeNotifier {
  final DatastoreManager datastore;

  LoginController(this.datastore);

  AuthStatus currentAuthStatus = AuthStatus.UNINITIALIZED;

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

  Future<void> login(
      {required String privateKey, required String publicKey}) async {
    bool privateKeySaved = await datastore.setPrivateKey(privateKey);
    bool publicKeySaved = await datastore.setPublicKey(publicKey);
    currentAuthStatus = (privateKeySaved && publicKeySaved)
        ? AuthStatus.AUTHENTICATED
        : AuthStatus.UNAUTHENTICATED;
    notifyListeners();
  }

  Future<void> logout() async {
    await datastore.setPrivateKey("");
    await datastore.setPublicKey("");
    currentAuthStatus = AuthStatus.UNAUTHENTICATED;
    notifyListeners();
  }
}
