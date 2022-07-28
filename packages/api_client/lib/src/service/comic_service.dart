import 'package:api_client/src/client/client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/model/model.dart';

/// {@template comic_service}
/// Service to access comics data from Marvel API server.
/// {@endtemplate}
class ComicService {
  /// {@macro comic_service}
  ComicService(
    this._baseUrl, {
    required DioApiClient apiClient,
  }) : _apiClient = apiClient;

  final DioApiClient _apiClient;
  final String _baseUrl;

  /// Endpoint for [ApiComic].
  static const comicsEndpoint = '/v1/public/comics';

  /// Gets [ApiComic] paginated data by [limit] and [offset].
  Future<ApiResult<ApiComic>> getComicsResult(
    int limit,
    int offset,
  ) async {
    final comicsRequest = Uri.https(
      _baseUrl,
      comicsEndpoint,
      <String, String>{'limit': '$limit', 'offset': '$offset'},
    );

    final response = await _apiClient.get(comicsRequest);

    // TODO(ruimiguel): think on put onSuccess and onError callbacks into
    // apiClient call.
    try {
      return ApiResult<ApiComic>.fromJson(
        response,
        (data) => ApiComic.fromJson(data! as Map<String, dynamic>),
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
