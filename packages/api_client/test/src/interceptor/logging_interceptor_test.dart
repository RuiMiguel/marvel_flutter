import 'dart:async';
import 'package:api_client/src/interceptor/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRequestOptions extends Mock implements RequestOptions {}

class _MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class _MockResponse extends Mock implements Response<dynamic> {}

class _MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class _MockDioError extends Mock implements DioError {}

class _MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  group('LoggingInterceptor', () {
    final log = <String>[];

    late final RequestOptions requestOptions;
    late final RequestInterceptorHandler requestInterceptorHandler;
    late final Response response;
    late final ResponseInterceptorHandler responseInterceptorHandler;
    late final DioError dioError;
    late final ErrorInterceptorHandler errorInterceptorHandler;
    late LoggingInterceptor loggingInterceptor;

    setUpAll(() {
      requestOptions = _MockRequestOptions();
      requestInterceptorHandler = _MockRequestInterceptorHandler();

      response = _MockResponse();
      responseInterceptorHandler = _MockResponseInterceptorHandler();

      final responseError = _MockResponse();
      dioError = _MockDioError();
      errorInterceptorHandler = _MockErrorInterceptorHandler();

      when(() => requestOptions.method).thenReturn('method');
      when(() => requestOptions.baseUrl).thenReturn('baseUrl');
      when(() => requestOptions.path).thenReturn('path');
      when(() => requestOptions.headers)
          .thenReturn(<String, String>{'key': 'value'});

      when(() => response.statusCode).thenReturn(1);
      when(() => response.data as String).thenReturn('baseUrl');

      when(() => responseError.statusCode).thenReturn(-1);
      when(() => dioError.response).thenReturn(responseError);
      when(() => dioError.type).thenReturn(DioErrorType.other);
      when(() => dioError.error as String).thenReturn('error');
    });

    void Function() overridePrint(void Function() testFn) => () {
          final spec = ZoneSpecification(
            print: (_, __, ___, String msg) {
              log.add(msg);
            },
          );
          return Zone.current.fork(specification: spec).run<void>(testFn);
        };

    group('log enabled', () {
      setUp(() {
        loggingInterceptor = LoggingInterceptor(logEnabled: true);
        log.clear();
      });

      test(
        'prints request on console',
        overridePrint(() {
          loggingInterceptor.onRequest(
            requestOptions,
            requestInterceptorHandler,
          );
          expect(log, isNotEmpty);
        }),
      );

      test(
        'prints responses on console',
        overridePrint(() {
          loggingInterceptor.onResponse(response, responseInterceptorHandler);
          expect(log, isNotEmpty);
        }),
      );

      test(
        'prints errors on console',
        overridePrint(() {
          loggingInterceptor.onError(dioError, errorInterceptorHandler);
          expect(log, isNotEmpty);
        }),
      );
    });

    group('log disabled', () {
      setUp(() {
        loggingInterceptor = LoggingInterceptor();
        log.clear();
      });

      test(
        "doesn't print request on console",
        overridePrint(() {
          loggingInterceptor.onRequest(
            requestOptions,
            requestInterceptorHandler,
          );
          expect(log, isEmpty);
        }),
      );

      test(
        "doesn't print responses on console",
        overridePrint(() {
          loggingInterceptor.onResponse(response, responseInterceptorHandler);
          expect(log, isEmpty);
        }),
      );

      test(
        "doesn't print errors on console",
        overridePrint(() {
          loggingInterceptor.onError(dioError, errorInterceptorHandler);
          expect(log, isEmpty);
        }),
      );
    });
  });
}
