import 'package:api_client/src/client/client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/interceptor/interceptor.dart';
import 'package:api_client/src/model/model.dart';
import 'package:api_client/src/security/security.dart';
import 'package:dio/dio.dart';

/// {@template character_service}
/// Service to access characters data from Marvel API server.
/// {@endtemplate}
class CharacterService {
  /// {@macro character_service}
  CharacterService(
    this._baseUrl, {
    required DioApiClient apiClient,
    required Security security,
  })  : _apiClient = apiClient,
        _security = security;

  final DioApiClient _apiClient;
  final Security _security;
  final String _baseUrl;

  /// Endpoint for [ApiCharacter].
  static const charactersEndpoint = '/v1/public/characters';

  /// Gets [ApiCharacter] paginated data by [limit] and [offset].
  Future<ApiResult<ApiCharacter>> getCharactersResult(
    int limit,
    int offset,
  ) async {
    final hashTimestamp = await _security.hashTimestamp();
    String publicKey;

    try {
      publicKey = await _security.publicKey;
    } catch (error, stackTrace) {
      throw AuthenticationException(error, stackTrace);
    }

    final charactersRequest = Uri.https(
      _baseUrl,
      charactersEndpoint,
      <String, String>{
        'ts': hashTimestamp['timestamp']!,
        'hash': hashTimestamp['hash']!,
        'apikey': publicKey,
        'limit': '$limit',
        'offset': '$offset'
      },
    );

    return _apiClient.get<ApiResult<ApiCharacter>>(
      charactersRequest,
      (success) {
        return ApiResult<ApiCharacter>.fromJson(
          success,
          (data) => ApiCharacter.fromJson(data! as Map<String, dynamic>),
        );
      },
      (code, error) {
        final response = ApiError.fromJson(error);
        throw ServerException(response);
      },
    );
  }
}
