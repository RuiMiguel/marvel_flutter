import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:marvel/data/datastore_manager.dart';
import 'package:marvel/data/model/api_character.dart';
import 'package:marvel/data/model/api_result.dart';

class CharacterApiClient {
  final DatastoreManager datastore;
  late String _privateKey;
  late String _publicKey;

  static const _baseUrl = 'gateway.marvel.com:443';
  static const CHARACTERS_ENDPOINT = '/v1/public/characters';
  final http.Client _httpClient = http.Client();

  CharacterApiClient(this.datastore) {
    _privateKey = datastore.getPrivateKey();
    _publicKey = datastore.getPublicKey();
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<List<ApiCharacter>> getCharacters(int limit, int offset) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateMd5("$timestamp$_privateKey$_publicKey");
    final apikey = _publicKey;

    final charactersRequest =
        Uri.https(_baseUrl, CHARACTERS_ENDPOINT, <String, String>{
      'ts': "$timestamp",
      'hash': hash,
      'apikey': apikey,
      'limit': "$limit",
      'offset': "$offset"
    });
    final charactersResponse = await _httpClient.get(charactersRequest);

    if (charactersResponse.statusCode != 200) {
      print("ERROR http");
    } else {
      print("RESPONSE: ${charactersResponse.body}");
    }

    var json = jsonDecode(charactersResponse.body);
    return ApiResult<ApiCharacter>.fromJson(
          json,
          (data) => ApiCharacter.fromJson(data as Map<String, dynamic>),
        ).data?.results ??
        List.empty();
  }

  Future<ApiResult<ApiCharacter>> getCharactersResult(
      int limit, int offset) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateMd5("$timestamp$_privateKey$_publicKey");
    final apikey = _publicKey;

    final charactersRequest =
        Uri.https(_baseUrl, CHARACTERS_ENDPOINT, <String, String>{
      'ts': "$timestamp",
      'hash': hash,
      'apikey': apikey,
      'limit': "$limit",
      'offset': "$offset"
    });
    final charactersResponse = await _httpClient.get(charactersRequest);

    if (charactersResponse.statusCode != 200) {
      print("ERROR http");
    } else {
      print("RESPONSE: ${charactersResponse.body}");
    }

    var json = jsonDecode(charactersResponse.body);
    return ApiResult<ApiCharacter>.fromJson(
      json,
      (data) => ApiCharacter.fromJson(data as Map<String, dynamic>),
    );
  }
}
