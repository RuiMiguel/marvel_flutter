import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:core_data_network/core_data_network.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_data/src/model/api_comic.dart';
import 'package:marvel_data/src/model/api_error.dart';
import 'package:marvel_data/src/model/api_result.dart';

class ComicsApiClient extends BaseApiClientDio {
  final String _baseUrl;
  late String privateKey;
  late String publicKey;

  static const COMICS_ENDPOINT = '/v1/public/comics';

  ComicsApiClient(this._baseUrl,
      {required this.privateKey,
      required this.publicKey,
      Dio? dio,
      bool logEnabled = false})
      : super(dio: dio, logEnabled: logEnabled);

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<Either<NetworkFailure, ApiResult<ApiComic>>> getComicsResult(
      int limit, int offset) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5("$timestamp$privateKey$publicKey");
    final apikey = publicKey;

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
            code: code.toString(),
            message: response.message ?? "",
          ),
        );
      },
      (exception) {
        var response = ApiError.fromJson(jsonDecode(exception.message));
        return Left(
          ServerFailure(
            code: exception.code.toString(),
            message: response.message ?? "",
          ),
        );
      },
    );
  }
}
