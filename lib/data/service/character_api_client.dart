import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:marvel/data/model/api_character.dart';
import 'package:marvel/data/model/api_result.dart';

class CharacterApiClient {
  static const _baseUrl = 'gateway.marvel.com:443';
  static const PRIVATE_KEY = "97b51487577e39179296e9cb2dccc9507198686c";
  static const PUBLIC_KEY = "585b45a00ec83ed8a2af91101942872e";

  static const CHARACTERS_ENDPOINT = '/v1/public/characters';

  final http.Client _httpClient = http.Client();

  CharacterApiClient();

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<List<ApiCharacter>> getCharacters(int limit, int offset) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5("$timestamp$PRIVATE_KEY$PUBLIC_KEY");
    final apikey = PUBLIC_KEY;

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
    final hash = generateMd5("$timestamp$PRIVATE_KEY$PUBLIC_KEY");
    final apikey = PUBLIC_KEY;

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
