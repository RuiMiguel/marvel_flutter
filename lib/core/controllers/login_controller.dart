import 'package:marvel/data/datastore_manager.dart';

class LoginController {
  final DatastoreManager datastore;

  LoginController(this.datastore);

  static const String PRIVATE_KEY = 'private_key';
  static const String PUBLICK_KEY = 'public_key';

  bool hasCredentials() {
    String privateKey = datastore.getPrivateKey();
    String publicKey = datastore.getPublicKey();
    return (privateKey.isNotEmpty && publicKey.isNotEmpty);
  }

  Future<bool> login(String privateKey, String publicKey) async {
    bool privateKeySaved = await datastore.setPrivateKey(privateKey);
    bool publicKeySaved = await datastore.setPublicKey(privateKey);
    return privateKeySaved && publicKeySaved;
  }

  Future<bool> logout() async {
    bool privateKeySaved = await datastore.setPrivateKey("");
    bool publicKeySaved = await datastore.setPublicKey("");
    return privateKeySaved && publicKeySaved;
  }
}
