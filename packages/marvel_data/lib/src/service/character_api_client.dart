import 'dart:convert';

import 'package:core_data_network/core_data_network.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:marvel_data/src/model/api_character.dart';
import 'package:marvel_data/src/model/api_error.dart';
import 'package:marvel_data/src/model/api_result.dart';

class CharacterApiClient extends BaseApiClientHttp {
  final String _baseUrl;
  late String privateKey;
  late String publicKey;

  static const CHARACTERS_ENDPOINT = '/v1/public/characters';

  CharacterApiClient(
    this._baseUrl, {
    required this.privateKey,
    required this.publicKey,
    Client? httpClient,
    bool logEnabled = false,
  }) : super(httpClient: httpClient, logEnabled: logEnabled);

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<Either<NetworkFailure, ApiResult<ApiCharacter>>> getCharactersResult(
      int limit, int offset) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateMd5("$timestamp$privateKey$publicKey");
    final apikey = publicKey;

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
        var response = ApiResult<ApiCharacter>.fromJson(
          success,
          (data) => ApiCharacter.fromJson(data as Map<String, dynamic>),
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
        return Left(exception);
      },
    );
  }
}
