// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiException', () {
    group('NetworkException', () {
      test('can be instantiated', () {
        expect(NetworkException('error'), isNotNull);
      });

      test('toString is correct', () {
        expect(
          NetworkException('error').toString(),
          equals('[NetworkException] error'),
        );
      });
    });

    group('ServerException', () {
      test('can be instantiated', () {
        expect(ServerException('error'), isNotNull);
      });

      test('toString is correct', () {
        expect(
          ServerException('error').toString(),
          equals('[ServerException] error'),
        );
      });
    });

    group('AuthenticationException', () {
      test('can be instantiated', () {
        expect(AuthenticationException('error'), isNotNull);
      });

      test('toString is correct', () {
        expect(
          AuthenticationException('error').toString(),
          equals('[AuthenticationException] error'),
        );
      });
    });

    group('DeserializationException', () {
      test('can be instantiated', () {
        expect(DeserializationException('error'), isNotNull);
        expect(DeserializationException.emptyResponseBody(), isNotNull);
      });

      test('toString is correct', () {
        expect(
          DeserializationException('error').toString(),
          equals('[DeserializationException] error'),
        );
        expect(
          DeserializationException.emptyResponseBody().toString(),
          equals('[DeserializationException] Empty response body'),
        );
      });
    });
  });
}
