import 'package:shared_preferences/shared_preferences.dart';

class DatastoreManager {
  final SharedPreferences preferences;

  DatastoreManager(this.preferences);

  static const String PRIVATE_KEY = 'private_key';
  static const String PUBLICK_KEY = 'public_key';

  String getPrivateKey() {
    return preferences.getString(PRIVATE_KEY) ?? "";
  }

  Future<bool> setPrivateKey(String privateKey) async {
    return preferences.setString(PRIVATE_KEY, privateKey);
  }

  String getPublicKey() {
    return preferences.getString(PUBLICK_KEY) ?? "";
  }

  Future<bool> setPublicKey(String publicKey) async {
    return preferences.setString(PUBLICK_KEY, publicKey);
  }
}
