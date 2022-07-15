import 'dart:convert';

import 'package:api_client/src/client/dio_api_client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/model/model.dart';
import 'package:api_client/src/security/security.dart';
import 'package:api_client/src/service/comic_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDioApiClient extends Mock implements DioApiClient {}

class _MockSecurity extends Mock implements Security {}

class _FakeUri extends Fake implements Uri {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(_FakeUri());
  });

  group('ComicService', () {
    const baseUrl = 'test.com';
    const publicKey = 'publicKey';
    const limit = 100;
    const offset = 50;

    late ComicService comicService;
    late DioApiClient apiClient;
    late Security security;

    setUp(() {
      apiClient = _MockDioApiClient();
      security = _MockSecurity();

      when(() => security.hashTimestamp()).thenAnswer(
        (_) async => {
          'timestamp': 'timestamp',
          'hash': 'hash',
        },
      );
      when(() => security.publicKey).thenAnswer((_) async => publicKey);

      comicService = ComicService(
        baseUrl,
        apiClient: apiClient,
        security: security,
      );
    });

    group('getComicsResult', () {
      Future<Map<String, String>> _generateQueryParameters() async {
        final hashTimestamp = await security.hashTimestamp();

        return <String, String>{
          'ts': hashTimestamp['timestamp']!,
          'hash': hashTimestamp['hash']!,
          'apikey': publicKey,
          'limit': '$limit',
          'offset': '$offset'
        };
      }

      test('returns NetworkException when request Get fails', () async {
        final _queryParameters = await _generateQueryParameters();
        const expected = NetworkException('error');

        when(
          () => apiClient.get(
            Uri.https(
              baseUrl,
              ComicService.comicsEndpoint,
              _queryParameters,
            ),
          ),
        ).thenThrow(expected);

        expect(
          comicService.getComicsResult(limit, offset),
          throwsA(isA<NetworkException>()),
        );
      });

      test('returns AuthenticationException when security fails', () async {
        when(() => security.publicKey)
            .thenThrow(const AuthenticationException(''));

        expect(
          comicService.getComicsResult(limit, offset),
          throwsA(isA<AuthenticationException>()),
        );
      });

      test('returns data error when request Get succeeded but with error',
          () async {
        final _queryParameters = await _generateQueryParameters();
        final data = jsonDecode(
          await rootBundle.loadString('test/assets/json/error.json'),
        ) as Map<String, dynamic>;

        when(
          () => apiClient.get(
            Uri.https(
              baseUrl,
              ComicService.comicsEndpoint,
              _queryParameters,
            ),
          ),
        ).thenAnswer((_) async => data);

        expect(
          comicService.getComicsResult(limit, offset),
          throwsA(
            isA<DeserializationException>().having(
              (element) => element.error,
              'error',
              isA<ApiError>()
                  .having(
                    (error) => error.code,
                    'error.code',
                    '1',
                  )
                  .having(
                    (error) => error.message,
                    'error.message',
                    'error',
                  ),
            ),
          ),
        );
      });

      test('returns data when request Get succeeded', () async {
        final _queryParameters = await _generateQueryParameters();
        final data = jsonDecode(
          await rootBundle.loadString('test/assets/json/comics_success.json'),
        ) as Map<String, dynamic>;

        when(
          () => apiClient.get(
            Uri.https(
              baseUrl,
              ComicService.comicsEndpoint,
              _queryParameters,
            ),
          ),
        ).thenAnswer((_) async => data);

        expect(
          await comicService.getComicsResult(limit, offset),
          isA<ApiResult<ApiComic>>(),
        );
      });
    });
  });
}
