import 'package:api_client/api_client.dart';
import 'package:api_client/src/client/client.dart';
import 'package:api_client/src/interceptor/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

class _MockLoggingInterceptor extends Mock implements LoggingInterceptor {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const path = 'test.com';
  const endpoint = '/endpoint';
  late Dio dio;
  late DioAdapter dioAdapter;
  late DioApiClient dioApiClient;

  group('DioApiClient', () {
    group('constructor', () {
      test('can be instantiated', () async {
        dio = _MockDio();
        expect(DioApiClient(dio: _MockDio()), isNotNull);
      });

      test('instantiates with loggingInterceptor adds it to Dio', () async {
        dio = Dio(BaseOptions());
        final loggingInterceptor = _MockLoggingInterceptor();

        expect(
          DioApiClient(
            dio: dio,
            loggingInterceptor: loggingInterceptor,
          ),
          isNotNull,
        );

        expect(dio.interceptors, contains(loggingInterceptor));
      });
    });

    group('get', () {
      setUp(() {
        dio = Dio(BaseOptions());

        dioApiClient = DioApiClient(dio: dio);
      });

      group('error', () {
        test('description', () async {
          const statusCode = 200;
          final data =
              await rootBundle.loadString('test/assets/json/comics_error.json');
          const expected = ApiError();
          var called = false;

          dioAdapter = DioAdapter(dio: dio)
            ..onGet(
              'https://test.com/endpoint',
              (server) => server.reply(
                statusCode,
                data,
              ),
            );
          dio.httpClientAdapter = dioAdapter;

          await dioApiClient.get<ApiError>(
            Uri.https(path, endpoint),
            (Map<String, dynamic> success) {
              return expected;
            },
            (code, Map<String, dynamic> error) {
              called = true;
              return expected;
            },
          );

          expect(called, isTrue);
        });
      });

      group('success', () {
        test('description', () async {
          const statusCode = 200;
          final data = await rootBundle
              .loadString('test/assets/json/comics_success.json');
          const expected = ApiResult<ApiComic>();
          var called = false;

          final pattern = Uri.https(path, endpoint).toString();

          dioAdapter.onGet(
            pattern,
            (server) => server.reply(
              statusCode,
              data,
            ),
          );

          await dioApiClient.get(
            Uri.https(path, endpoint),
            (Map<String, dynamic> success) {
              called = true;
              return expected;
            },
            (code, Map<String, dynamic> error) {
              return;
            },
          );

          expect(called, isTrue);
        });
      });
    });

    group('post', () {});
  });
}
