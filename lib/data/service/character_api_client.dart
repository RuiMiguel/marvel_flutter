import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:marvel/data/datastore_manager.dart';
import 'package:marvel/data/model/api_character.dart';
import 'package:marvel/data/model/api_result.dart';
import 'package:marvel/data/service/base_api_client_http.dart';

class CharacterApiClient extends BaseApiClientHttp {
  final String _baseUrl;
  final DatastoreManager datastore;
  late String _privateKey;
  late String _publicKey;

  static const CHARACTERS_ENDPOINT = '/v1/public/characters';

  CharacterApiClient(this._baseUrl, this.datastore, bool logEnabled)
      : super(logEnabled) {
    _privateKey = datastore.getPrivateKey();
    _publicKey = datastore.getPublicKey();
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<List<ApiCharacter>> getCharacters(int limit, int offset) {
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

    return requestGet(
      charactersRequest,
      (success) {
        return ApiResult<ApiCharacter>.fromJson(
              success,
              (data) => ApiCharacter.fromJson(data as Map<String, dynamic>),
            ).data?.results ??
            List.empty();
      },
      (code, error) {
        return List.empty();
      },
    );
  }

  Future<ApiResult<ApiCharacter>> getCharactersResult(int limit, int offset) {
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

    return requestGet(
      charactersRequest,
      (success) {
        return ApiResult<ApiCharacter>.fromJson(
          success,
          (data) => ApiCharacter.fromJson(data as Map<String, dynamic>),
        );
      },
      (code, error) {
        return ApiResult();
      },
    );
  }
}
