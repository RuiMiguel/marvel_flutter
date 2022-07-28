import 'package:api_client/src/client/client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/model/model.dart';

/// {@template character_service}
/// Service to access characters data from Marvel API server.
/// {@endtemplate}
class CharacterService {
  /// {@macro character_service}
  CharacterService(
    this._baseUrl, {
    required DioApiClient apiClient,
  }) : _apiClient = apiClient;

  final DioApiClient _apiClient;
  final String _baseUrl;

  /// Endpoint for [ApiCharacter].
  static const charactersEndpoint = '/v1/public/characters';

  /// Gets [ApiCharacter] paginated data by [limit] and [offset].
  Future<ApiResult<ApiCharacter>> getCharactersResult(
    int limit,
    int offset,
  ) async {
    final charactersRequest = Uri.https(
      _baseUrl,
      charactersEndpoint,
      <String, String>{'limit': '$limit', 'offset': '$offset'},
    );

    final response = await _apiClient.get(charactersRequest);

    // TODO(ruimiguel): think on put onSuccess and onError callbacks into
    // apiClient call.
    try {
      return ApiResult<ApiCharacter>.fromJson(
        response,
        (data) => ApiCharacter.fromJson(data! as Map<String, dynamic>),
      );
    } catch (error, stackTrace) {
      final responseError = ApiError.fromJson(response);
      if (error is DeserializationException) {
        rethrow;
      } else {
        throw DeserializationException(responseError, stackTrace);
      }
    }
  }
}
