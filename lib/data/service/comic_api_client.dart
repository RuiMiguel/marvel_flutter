import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:marvel/data/datastore_manager.dart';
import 'package:marvel/data/model/api_comic.dart';
import 'package:marvel/data/model/api_result.dart';
import 'package:marvel/data/service/base_api_client_dio.dart';

class ComicsApiClient extends BaseApiClientDio {
  final String _baseUrl;
  final DatastoreManager datastore;
  late String _privateKey;
  late String _publicKey;

  static const COMICS_ENDPOINT = '/v1/public/comics';

  ComicsApiClient(this._baseUrl, this.datastore, bool logEnabled)
      : super(logEnabled) {
    _privateKey = datastore.getPrivateKey();
    _publicKey = datastore.getPublicKey();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<List<ApiComic>> getComics(int limit, int offset) {
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

    return requestGet(
      comicsRequest,
      (success) {
        return ApiResult<ApiComic>.fromJson(
              success,
              (data) => ApiComic.fromJson(data as Map<String, dynamic>),
            ).data?.results ??
            List.empty();
      },
      (code, error) {
        return List.empty();
      },
    );
  }

  Future<ApiResult<ApiComic>> getComicsResult(int limit, int offset) {
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

    return requestGet(
      comicsRequest,
      (success) {
        return ApiResult<ApiComic>.fromJson(
          success,
          (data) => ApiComic.fromJson(data as Map<String, dynamic>),
        );
      },
      (code, error) {
        return ApiResult();
      },
    );
  }
}
