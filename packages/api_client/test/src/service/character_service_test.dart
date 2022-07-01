import 'package:api_client/src/client/dio_api_client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/model/model.dart';
import 'package:api_client/src/security/security.dart';
import 'package:api_client/src/service/character_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDioApiClient extends Mock implements DioApiClient {}

class _MockSecurity extends Mock implements Security {}

class _FakeUri extends Fake implements Uri {}

void main() {
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
        security: security,
      );
    });

    group('getCharactersResult', () {
      Future<Map<String, String>> _generateHeaders() async {
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
        final _headers = await _generateHeaders();
        const expected = NetworkException('error');

        when(
          () => apiClient.get<ApiResult<ApiCharacter>>(
            Uri.https(
              baseUrl,
              CharacterService.charactersEndpoint,
              _headers,
            ),
            any(),
            any(),
          ),
        ).thenThrow(expected);

        expect(
          characterService.getCharactersResult(limit, offset),
          throwsA(isA<NetworkException>()),
        );
      });

      test('returns AuthenticationException when security fails', () async {
        when(() => security.publicKey)
            .thenThrow(const AuthenticationException(''));

        expect(
          characterService.getCharactersResult(limit, offset),
          throwsA(isA<AuthenticationException>()),
        );
      });

      test('returns data error when request Get succeeded but with error',
          () async {
        final _headers = await _generateHeaders();
        const error = ApiError();
        const expected = ServerException(error);

        when(
          () => apiClient.get<ApiResult<ApiCharacter>>(
            Uri.https(
              baseUrl,
              CharacterService.charactersEndpoint,
              _headers,
            ),
            any(),
            any(),
          ),
        ).thenThrow(expected);

        expect(
          characterService.getCharactersResult(limit, offset),
          throwsA(
            isA<ServerException>().having((e) => e.error, 'error', error),
          ),
        );
      });

      test('returns data when request Get succeeded', () async {
        final _headers = await _generateHeaders();
        const expected = ApiResult<ApiCharacter>();

        when(
          () => apiClient.get<ApiResult<ApiCharacter>>(
            Uri.https(
              baseUrl,
              CharacterService.charactersEndpoint,
              _headers,
            ),
            any(),
            any(),
          ),
        ).thenAnswer((_) async => expected);

        expect(
          await characterService.getCharactersResult(limit, offset),
          expected,
        );
      });
    });
  });
}
