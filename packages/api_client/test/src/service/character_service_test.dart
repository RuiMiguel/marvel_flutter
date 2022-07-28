// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:api_client/src/client/dio_api_client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/model/model.dart';
import 'package:api_client/src/security/security.dart';
import 'package:api_client/src/service/character_service.dart';
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

  group('CharacterService', () {
    const baseUrl = 'test.com';
    const publicKey = 'publicKey';
    const limit = 100;
    const offset = 50;

    late CharacterService characterService;
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

      characterService = CharacterService(
        baseUrl,
        apiClient: apiClient,
      );
    });

    group('getCharactersResult', () {
      Future<Map<String, String>> _generateQueryParameters() async {
        final hashTimestamp = await security.hashTimestamp();

        return <String, String>{'limit': '$limit', 'offset': '$offset'};
      }

      test('returns NetworkException when request Get fails', () async {
        final _queryParameters = await _generateQueryParameters();

        when(
          () => apiClient.get(
            Uri.https(
              baseUrl,
              CharacterService.charactersEndpoint,
              _queryParameters,
            ),
          ),
        ).thenThrow(NetworkException('error'));

        expect(
          characterService.getCharactersResult(limit, offset),
          throwsA(isA<NetworkException>()),
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
              CharacterService.charactersEndpoint,
              _queryParameters,
            ),
          ),
        ).thenAnswer((_) async => data);

        expect(
          characterService.getCharactersResult(limit, offset),
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
          await rootBundle
              .loadString('test/assets/json/characters_success.json'),
        ) as Map<String, dynamic>;

        when(
          () => apiClient.get(
            Uri.https(
              baseUrl,
              CharacterService.charactersEndpoint,
              _queryParameters,
            ),
          ),
        ).thenAnswer((_) async => data);

        expect(
          await characterService.getCharactersResult(limit, offset),
          isA<ApiResult<ApiCharacter>>(),
        );
      });
    });
  });
}
