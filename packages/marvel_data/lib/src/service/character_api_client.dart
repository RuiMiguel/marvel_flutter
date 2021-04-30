import 'dart:convert';

import 'package:core_data_network/core_data_network.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:marvel_data/src/model/api_character.dart';
import 'package:marvel_data/src/model/api_error.dart';
import 'package:marvel_data/src/model/api_result.dart';

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

  Future<Either<NetworkFailure, List<ApiCharacter>>> getCharacters(
      int limit, int offset) {
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
        var response = ApiResult<ApiCharacter>.fromJson(
              success,
              (data) => ApiCharacter.fromJson(data as Map<String, dynamic>),
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

  Future<Either<NetworkFailure, ApiResult<ApiCharacter>>> getCharactersResult(
      int limit, int offset) {
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
