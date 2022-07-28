import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/interceptor/interceptor.dart';
import 'package:api_client/src/security/security.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecurity extends Mock implements Security {}

class _MockRequestOptions extends Mock implements RequestOptions {}

class _MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class _MockResponse extends Mock implements Response<dynamic> {}

class _MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

void main() {
  group('AuthInterceptor', () {
    const timestamp = 'timestamp';
    const hash = 'hash';
    const publicKey = 'publicKey';

    late final RequestOptions requestOptions;
    late final RequestInterceptorHandler requestInterceptorHandler;
    late final Response response;
    late final ResponseInterceptorHandler responseInterceptorHandler;
    late Security security;
    late AuthInterceptor authInterceptor;

    setUp(() {
      security = _MockSecurity();
      when(security.hashTimestamp).thenAnswer(
        (_) async => {
          'timestamp': timestamp,
          'hash': hash,
        },
      );
      authInterceptor = AuthInterceptor(security: security);
    });

    setUpAll(() {
      requestOptions = _MockRequestOptions();
      requestInterceptorHandler = _MockRequestInterceptorHandler();

      response = _MockResponse();
      responseInterceptorHandler = _MockResponseInterceptorHandler();

      when(() => requestOptions.method).thenReturn('method');
      when(() => requestOptions.baseUrl).thenReturn('baseUrl');
      when(() => requestOptions.path).thenReturn('path');
      when(() => requestOptions.headers)
          .thenReturn(<String, String>{'key': 'value'});

      when(() => response.statusCode).thenReturn(1);
      when(() => response.data as String).thenReturn('baseUrl');
    });

    test('returns AuthenticationException when security fails', () async {
      when(() => security.publicKey)
          .thenThrow(const AuthenticationException(''));

      expect(
        authInterceptor.onRequest(
          requestOptions,
          requestInterceptorHandler,
        ),
        throwsA(isA<AuthenticationException>()),
      );
    });

    test('continues request with new queryParameters', () async {
      when(() => security.publicKey).thenAnswer((_) async => publicKey);

      final requestOptions = RequestOptions(path: 'path');

      expect(requestOptions.queryParameters, isEmpty);

      await authInterceptor.onRequest(
        requestOptions,
        requestInterceptorHandler,
      );

      expect(requestOptions.queryParameters, containsPair('ts', timestamp));
      expect(requestOptions.queryParameters, containsPair('hash', hash));
      expect(requestOptions.queryParameters, containsPair('apikey', publicKey));
    });
  });
}
