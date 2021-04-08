import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:marvel/data/model/api_comic.dart';
import 'package:marvel/data/model/api_result.dart';

import '../datastore_manager.dart';

class ComicsApiClient {
  final DatastoreManager datastore;
  late String _privateKey;
  late String _publicKey;

  static const _baseUrl = 'gateway.marvel.com:443';
  static const COMICS_ENDPOINT = '/v1/public/comics';

  final http.Client _httpClient = http.Client();

  ComicsApiClient(this.datastore) {
    _privateKey = datastore.getPrivateKey();
    _publicKey = datastore.getPublicKey();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<List<ApiComic>> getComics(int limit, int offset) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5("$timestamp$_privateKey$_publicKey");
    final apikey = _publicKey;

    final comicsRequest = Uri.https(_baseUrl, COMICS_ENDPOINT, <String, String>{
      'ts': "$timestamp",
      'hash': hash,
      'apikey': apikey,
      'limit': "$limit",
      'offset': "$offset"
    });
    final comicsResponse = await _httpClient.get(comicsRequest);

    if (comicsResponse.statusCode != 200) {
      print("ERROR http");
    } else {
      print("RESPONSE: ${comicsResponse.body}");
    }

    var json = jsonDecode(comicsResponse.body);
    return ApiResult<ApiComic>.fromJson(
          json,
          (data) => ApiComic.fromJson(data as Map<String, dynamic>),
        ).data?.results ??
        List.empty();
  }

  Future<ApiResult<ApiComic>> getComicsResult(int limit, int offset) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5("$timestamp$_privateKey$_publicKey");
    final apikey = _publicKey;

    final comicsRequest = Uri.https(_baseUrl, COMICS_ENDPOINT, <String, String>{
      'ts': "$timestamp",
      'hash': hash,
      'apikey': apikey,
      'limit': "$limit",
      'offset': "$offset"
    });
    final comicsResponse = await _httpClient.get(comicsRequest);

    if (comicsResponse.statusCode != 200) {
      print("ERROR http");
    } else {
      print("RESPONSE: ${comicsResponse.body}");
    }

    var json = jsonDecode(comicsResponse.body);
    return ApiResult<ApiComic>.fromJson(
      json,
      (data) => ApiComic.fromJson(data as Map<String, dynamic>),
    );
  }
}
