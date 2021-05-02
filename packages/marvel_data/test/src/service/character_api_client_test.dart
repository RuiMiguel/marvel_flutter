import 'dart:io';

import 'package:core_data_network/core_data_network.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:marvel_data/src/model/api_character.dart';
import 'package:marvel_data/src/model/api_result.dart';
import 'package:marvel_data/src/service/character_api_client.dart';

import '../utils/either.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const _baseUrl = "fake-url.com";
  late MockClient _httpClient;
  late CharacterApiClient characterApiClient;

  void _initApiClient(MockClient httpClient) {
    _httpClient = httpClient;
    characterApiClient = CharacterApiClient(
      _baseUrl,
      privateKey: "FAKE_PRIVATE_KEY",
      publicKey: "FAKE_PUBLIC_KEY",
      httpClient: _httpClient,
    );
  }

  http.Response _makeResponse(String data, int statusCode) {
    return http.Response(
      data,
      statusCode,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
    );
  }

  group('CharacterApiClient', () {
    setUp(() {
      _initApiClient(MockClient((_) async {
        return _makeResponse("", 200);
      }));
    });

    group('getCharactersResult', () {
      test('returns NetworkFailure when apiclient fails', () async {
        int _limit = 100;
        int _offset = 50;

        var statusCode = 401;
        var data =
            await rootBundle.loadString('assets/json/characters_error.json');

        _httpClient = MockClient((_) async {
          return _makeResponse(data, statusCode);
        });
        _initApiClient(_httpClient);

        var either =
            await characterApiClient.getCharactersResult(_limit, _offset);

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var left = either.l();
        expect(left, isA<ServerFailure>());
        expect((left as ServerFailure).code, equals("$statusCode"));
      });

      test('returns success when apiclient returns ApiResult', () async {
        int _limit = 100;
        int _offset = 50;

        var statusCode = 200;
        var data =
            await rootBundle.loadString('assets/json/characters_success.json');

        _httpClient = MockClient((_) async {
          return _makeResponse(data, statusCode);
        });
        _initApiClient(_httpClient);

        var either =
            await characterApiClient.getCharactersResult(_limit, _offset);

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var right = either.r();
        expect(right, isA<ApiResult>());
        expect(right.data?.results, isA<List<ApiCharacter>>());
      });
    });
  });
}
