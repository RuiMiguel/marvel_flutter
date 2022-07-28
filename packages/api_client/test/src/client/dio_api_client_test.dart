import 'package:api_client/src/client/dio_api_client.dart';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/interceptor/auth_interceptor.dart';
import 'package:api_client/src/interceptor/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

class _MockLoggingInterceptor extends Mock implements LoggingInterceptor {}

class _MockAuthInterceptor extends Mock implements AuthInterceptor {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const path = 'test.com';
  const endpoint = '/endpoint';
  late Dio dio;
  late DioAdapter dioAdapter;
  late DioApiClient dioApiClient;

  group('DioApiClient', () {
    setUp(() {
      dio = Dio(BaseOptions());
      dioApiClient = DioApiClient(dio: dio);
    });

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

      test('instantiates with authInterceptor adds it to Dio', () async {
        dio = Dio(BaseOptions());
        final authInterceptor = _MockAuthInterceptor();

        expect(
          DioApiClient(
            dio: dio,
            authInterceptor: authInterceptor,
          ),
          isNotNull,
        );

        expect(dio.interceptors, contains(authInterceptor));
      });
    });

    group('get', () {
      test(
          'throws NetworkException '
          'when dio fails', () async {
        dioAdapter = DioAdapter(dio: dio)
          ..onGet(
            'https://test.com/endpoint',
            (server) => server.throws(
              500,
              DioError(
                requestOptions: RequestOptions(path: path),
              ),
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        try {
          await dioApiClient.get(
            Uri.https(path, endpoint),
          );
          fail('should throw');
        } catch (error) {
          expect(error, isA<NetworkException>());
        }
      });

      test(
          'throws DeserializationException '
          'when dio returns an wrong empty response', () async {
        const statusCode = 200;

        dioAdapter = DioAdapter(dio: dio)
          ..onGet(
            'https://test.com/endpoint',
            (server) => server.reply(
              statusCode,
              null,
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        try {
          await dioApiClient.get(
            Uri.https(path, endpoint),
          );
          fail('should throw');
        } catch (error) {
          expect(error, isA<DeserializationException>());
        }
      });

      test(
          'returns response '
          'when dio succeeds with data', () async {
        dioAdapter = DioAdapter(dio: dio)
          ..onGet(
            'https://test.com/endpoint',
            (server) => server.reply(
              200,
              {'data': ''},
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        expect(
          dioApiClient.get(
            Uri.https(path, endpoint),
          ),
          completes,
        );
      });

      test(
          'returns response '
          'when dio succeeds with empty data', () async {
        dioAdapter = DioAdapter(dio: dio)
          ..onGet(
            'https://test.com/endpoint',
            (server) => server.reply(
              204,
              null,
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        expect(
          dioApiClient.get(
            Uri.https(path, endpoint),
          ),
          completes,
        );
      });
    });

    group('post', () {
      test(
          'throws NetworkException '
          'when dio fails', () async {
        dioAdapter = DioAdapter(dio: dio)
          ..onPost(
            'https://test.com/endpoint',
            data: <String, String>{'key': 'value'},
            (server) => server.throws(
              500,
              DioError(
                requestOptions: RequestOptions(path: path),
              ),
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        try {
          await dioApiClient.post(
            Uri.https(path, endpoint),
            body: <String, String>{'key': 'value'},
          );
          fail('should throw');
        } catch (error) {
          expect(error, isA<NetworkException>());
        }
      });

      test(
          'throws DeserializationException '
          'when dio returns an wrong empty response', () async {
        const statusCode = 200;

        dioAdapter = DioAdapter(dio: dio)
          ..onPost(
            'https://test.com/endpoint',
            data: <String, String>{'key': 'value'},
            (server) => server.reply(
              statusCode,
              null,
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        try {
          await dioApiClient.post(
            Uri.https(path, endpoint),
            body: <String, String>{'key': 'value'},
          );
          fail('should throw');
        } catch (error) {
          expect(error, isA<DeserializationException>());
        }
      });

      test(
          'returns response '
          'when dio succeeds with data', () async {
        dioAdapter = DioAdapter(dio: dio)
          ..onPost(
            'https://test.com/endpoint',
            data: <String, String>{'key': 'value'},
            (server) => server.reply(
              200,
              {'data': ''},
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        expect(
          dioApiClient.post(
            Uri.https(path, endpoint),
            body: <String, String>{'key': 'value'},
          ),
          completes,
        );
      });

      test(
          'returns response '
          'when dio succeeds with empty data', () async {
        dioAdapter = DioAdapter(dio: dio)
          ..onPost(
            'https://test.com/endpoint',
            data: <String, String>{'key': 'value'},
            (server) => server.reply(
              204,
              null,
            ),
          );
        dio.httpClientAdapter = dioAdapter;

        expect(
          dioApiClient.post(
            Uri.https(path, endpoint),
            body: <String, String>{'key': 'value'},
          ),
          completes,
        );
      });
    });
  });
}
