import 'dart:io';

import 'package:core_data_network/core_data_network.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:marvel_data/src/model/api_comic.dart';
import 'package:marvel_data/src/model/api_result.dart';
import 'package:marvel_data/src/service/comic_api_client.dart';
import 'package:mockito/mockito.dart';

import '../utils/either.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const _baseUrl = "fake-url.com";
  late DioAdapterMockito dioAdapter;
  late Dio dio;
  late ComicsApiClient comicsApiClient;

  void _initApiClient(DioAdapterMockito _dioAdapter) {
    dioAdapter = _dioAdapter;
    dio = Dio()
      ..interceptors.add(LogginInterceptor(true))
      ..httpClientAdapter = dioAdapter;
    comicsApiClient = ComicsApiClient(
      _baseUrl,
      privateKey: "FAKE_PRIVATE_KEY",
      publicKey: "FAKE_PUBLIC_KEY",
      dio: dio,
    );
  }

  ResponseBody _makeResponse(String data, int statusCode) {
    return ResponseBody.fromString(
      data,
      statusCode,
      headers: {
        HttpHeaders.contentTypeHeader: ['application/json; charset=utf-8'],
      },
    );
  }

  group('ComicsApiClient', () {
    setUp(() {
      _initApiClient(DioAdapterMockito());
    });

    group('getComicsResult', () {
      test('returns NetworkFailure when apiclient fails', () async {
        int _limit = 100;
        int _offset = 50;

        var statusCode = 401;
        var data = await rootBundle.loadString('assets/json/comics_error.json');

        var dioAdapter = DioAdapterMockito();
        when(dioAdapter.fetch(any, any, any)).thenAnswer(
          (_) async => _makeResponse(data, statusCode),
        );

        _initApiClient(dioAdapter);

        Either<NetworkFailure, ApiResult<ApiComic>> either;
        try {
          either = await comicsApiClient.getComicsResult(_limit, _offset);
        } catch (e) {
          either = Left(ServerFailure());
        }

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var left = either.l();
        expect(left, isA<ServerFailure>());
      });

      test('returns success when apiclient returns ApiResult', () async {
        int _limit = 100;
        int _offset = 50;

        var statusCode = 200;
        var data =
            await rootBundle.loadString('assets/json/comics_success.json');

        var dioAdapter = DioAdapterMockito();
        when(dioAdapter.fetch(any, any, any)).thenAnswer(
          (_) async => _makeResponse(data, statusCode),
        );
        _initApiClient(dioAdapter);

        var either = await comicsApiClient.getComicsResult(_limit, _offset);

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var right = either.r();
        expect(right, isA<ApiResult>());
        expect(right.data?.results, isA<List<ApiComic>>());
      });
    });
  });
}
