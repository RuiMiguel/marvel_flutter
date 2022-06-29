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

  /// Endpoint for [ApiComic].
  static const comicsEndpoint = '/v1/public/comics';

  /// Gets [ApiComic] paginated data by [limit] and [offset].
  Future<ApiResult<ApiComic>> getComicsResult(
    int limit,
    int offset,
  ) async {
    final hashTimestamp = _security.hashTimestamp();

    final comicsRequest = Uri.https(
      _baseUrl,
      comicsEndpoint,
      <String, String>{
        'ts': hashTimestamp['timestamp']!,
        'hash': hashTimestamp['hash']!,
        'apikey': _publicKey,
        'limit': '$limit',
        'offset': '$offset'
      },
    );

    return _apiClient.get<ApiResult<ApiComic>>(
      comicsRequest,
      (Map<String, dynamic> success) {
        final response = ApiResult<ApiComic>.fromJson(
          success,
          (data) => data != null
              ? ApiComic.fromJson(data as Map<String, dynamic>)
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
