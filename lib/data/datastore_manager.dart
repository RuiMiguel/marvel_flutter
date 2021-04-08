import 'package:shared_preferences/shared_preferences.dart';

class DatastoreManager {
  final SharedPreferences preferences;

  DatastoreManager(this.preferences);

  static const String PRIVATE_KEY = 'private_key';
  static const String PUBLICK_KEY = 'public_key';

  String getPrivateKey() {
    //return preferences.getString(PRIVATE_KEY) ?? "";
    return "97b51487577e39179296e9cb2dccc9507198686c";
  }

  Future<bool> setPrivateKey(String privateKey) async {
    return preferences.setString(PRIVATE_KEY, privateKey);
  }

  String getPublicKey() {
    //return preferences.getString(PUBLICK_KEY) ?? "";
    return "585b45a00ec83ed8a2af91101942872e";
  }

  Future<bool> setPublicKey(String publicKey) async {
    return preferences.setString(PUBLICK_KEY, publicKey);
  }
}
