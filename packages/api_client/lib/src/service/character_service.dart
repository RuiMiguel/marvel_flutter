import 'package:api_client/src/client/client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/model/model.dart';
import 'package:api_client/src/security/security.dart';

/// {@template character_service}
/// Service to access characters data from Marvel API server.
/// {@endtemplate}
class CharacterService {
  /// {@macro character_service}
  CharacterService(
    this._baseUrl, {
    required String publicKey,
    required DioApiClient apiClient,
    required Security security,
  })  : _publicKey = publicKey,
        _apiClient = apiClient,
        _security = security;

  final DioApiClient _apiClient;
  final Security _security;
  final String _baseUrl;
  final String _publicKey;

  /// Endpoint for [ApiCharacter].
  static const charactersEndpoint = '/v1/public/characters';

  /// Gets [ApiCharacter] paginated data by [limit] and [offset].
  Future<ApiResult<ApiCharacter>> getCharactersResult(
    int limit,
    int offset,
  ) async {
    final hashTimestamp = _security.hashTimestamp();

    final charactersRequest = Uri.https(
      _baseUrl,
      charactersEndpoint,
      <String, String>{
        'ts': hashTimestamp['timestamp']!,
        'hash': hashTimestamp['hash']!,
        'apikey': _publicKey,
        'limit': '$limit',
        'offset': '$offset'
      },
    );

    return _apiClient.get<ApiResult<ApiCharacter>>(
      charactersRequest,
      (Map<String, dynamic> success) {
        final response = ApiResult<ApiCharacter>.fromJson(
          success,
          (data) => data != null
              ? ApiCharacter.fromJson(data as Map<String, dynamic>)
              : throw const DeserializationException.emptyResponseBody(),
        );

        return response;
      },
      (code, Map<String, dynamic> error) {
        final response = ApiError.fromJson(error);
        throw ServerException(response);
      },
    );
  }
}
