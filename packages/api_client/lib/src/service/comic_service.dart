import 'package:api_client/src/client/client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/model/model.dart';
import 'package:api_client/src/security/security.dart';

/// {@template comic_service}
/// Service to access comics data from Marvel API server.
/// {@endtemplate}
class ComicService {
  /// {@macro comic_service}
  ComicService(
    this._baseUrl, {
    required DioApiClient apiClient,
    required Security security,
  })  : _apiClient = apiClient,
        _security = security;

  final DioApiClient _apiClient;
  final Security _security;
  final String _baseUrl;

  /// Endpoint for [ApiComic].
  static const comicsEndpoint = '/v1/public/comics';

  /// Gets [ApiComic] paginated data by [limit] and [offset].
  Future<ApiResult<ApiComic>> getComicsResult(
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

    final comicsRequest = Uri.https(
      _baseUrl,
      comicsEndpoint,
      <String, String>{
        'ts': hashTimestamp['timestamp']!,
        'hash': hashTimestamp['hash']!,
        'apikey': publicKey,
        'limit': '$limit',
        'offset': '$offset'
      },
    );

    return _apiClient.get<ApiResult<ApiComic>>(
      comicsRequest,
      (success) {
        final response = ApiResult<ApiComic>.fromJson(
          success,
          (data) => ApiComic.fromJson(data! as Map<String, dynamic>),
        );
        return response;
      },
      (code, error) {
        final response = ApiError.fromJson(error);
        throw ServerException(response);
      },
    );
  }
}
