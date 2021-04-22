import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel/data/base/error/data_failure.dart';
import 'package:marvel/data/datastore_manager.dart';
import 'package:marvel/data/model/api_comic.dart';
import 'package:marvel/data/model/api_error.dart';
import 'package:marvel/data/model/api_result.dart';
import 'package:marvel/data/service/base_api_client_dio.dart';

class ComicsApiClient extends BaseApiClientDio {
  final String _baseUrl;
  final DatastoreManager datastore;
  late String _privateKey;
  late String _publicKey;

  static const COMICS_ENDPOINT = '/v1/public/comics';

  ComicsApiClient(this._baseUrl, this.datastore, bool logEnabled,
      int _connectTimeout, int _receiveTimeout)
      : super(logEnabled, _connectTimeout, _receiveTimeout) {
    _privateKey = datastore.getPrivateKey();
    _publicKey = datastore.getPublicKey();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<Either<NetworkFailure, List<ApiComic>>> getComics(
      int limit, int offset) {
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
        var response = ApiResult<ApiComic>.fromJson(
              success,
              (data) => ApiComic.fromJson(data as Map<String, dynamic>),
            ).data?.results ??
            List.empty();
        return Right(response);
      },
      (code, error) {
        var response = ApiError.fromJson(error);
        return Left(
          ServerFailure(
            code: response.code ?? code.toString(),
            message: response.message ?? "",
          ),
        );
      },
      (exception) {
        return Left(exception);
      },
    );
  }

  Future<Either<NetworkFailure, ApiResult<ApiComic>>> getComicsResult(
      int limit, int offset) {
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
        var response = ApiResult<ApiComic>.fromJson(
          success,
          (data) => ApiComic.fromJson(data as Map<String, dynamic>),
        );
        return Right(response);
      },
      (code, error) {
        var response = ApiError.fromJson(error);
        return Left(
          ServerFailure(
            code: response.code ?? code.toString(),
            message: response.message ?? "",
          ),
        );
      },
      (exception) {
        return Left(exception);
      },
    );
  }
}
