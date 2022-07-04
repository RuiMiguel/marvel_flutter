// ignore_for_file: prefer_const_constructors
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage/secure_storage.dart';

class _MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  const _publicKeyField = '__publicKeyField__';
  const _privateKeyField = '__privateKeyField__';

  late FlutterSecureStorage flutterSecureStorage;
  late SecureStorage secureStorage;

  group('SecureStorage', () {
    setUp(() {
      flutterSecureStorage = _MockFlutterSecureStorage();
      secureStorage = SecureStorage(secureStorage: flutterSecureStorage);
    });

    test('can be instantiated', () {
      expect(SecureStorage(secureStorage: flutterSecureStorage), isNotNull);
    });

    test(
        'can be instantiated with default FlutterSecureStorage if not provided',
        () {
      expect(SecureStorage(), isNotNull);
    });

    group('publicKey', () {
      test('returns value when read from storage succeeded', () async {
        const expected = 'publicKey';
        when(() => flutterSecureStorage.read(key: _publicKeyField))
            .thenAnswer((_) async => expected);

        expect(await secureStorage.publicKey(), expected);
      });

      test('throws ReadException when read from storage is null', () async {
        const expected = ReadException('Empty publicKey');
        when(() => flutterSecureStorage.read(key: _publicKeyField))
            .thenAnswer((_) async => null);

        try {
          await secureStorage.publicKey();
        } on ReadException catch (e) {
          expect(e.error, expected);
          expect(e.stackTrace, isNotNull);
        }
      });

      test('throws ReadException when read from storage fails', () async {
        const expected = ReadException('error');
        when(() => flutterSecureStorage.read(key: _publicKeyField))
            .thenThrow(expected);

        try {
          await secureStorage.publicKey();
        } on ReadException catch (e) {
          expect(e.error, expected);
          expect(e.stackTrace, isNotNull);
        }
      });
    });

    group('privateKey', () {
      test('returns value when read from storage succeeded', () async {
        const expected = 'privateKey';
        when(() => flutterSecureStorage.read(key: _privateKeyField))
            .thenAnswer((_) async => expected);

        expect(await secureStorage.privateKey(), expected);
      });

      test('throws ReadException when read from storage is null', () async {
        const expected = ReadException('Empty privateKey');
        when(() => flutterSecureStorage.read(key: _privateKeyField))
            .thenAnswer((_) async => null);

        try {
          await secureStorage.privateKey();
        } on ReadException catch (e) {
          expect(e.error, expected);
          expect(e.stackTrace, isNotNull);
        }
      });

      test('throws ReadException when read from storage fails', () async {
        const expected = ReadException('error');
        when(() => flutterSecureStorage.read(key: _privateKeyField))
            .thenThrow(expected);

        try {
          await secureStorage.privateKey();
        } on ReadException catch (e) {
          expect(e.error, expected);
          expect(e.stackTrace, isNotNull);
        }
      });
    });

    group('saveCredentials', () {
      test('completes when write on storage succeeded', () async {
        when(
          () => flutterSecureStorage.write(
            key: _privateKeyField,
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => Future.value());
        when(
          () => flutterSecureStorage.write(
            key: _publicKeyField,
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => Future.value());

        expect(
          secureStorage.saveCredentials(privateKey: '', publicKey: ''),
          completes,
        );
      });

      test('throws WriteException when write on storage fails', () async {
        const expected = WriteException('error');
        when(
          () => flutterSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenThrow(expected);

        try {
          await secureStorage.saveCredentials(privateKey: '', publicKey: '');
        } on StorageException catch (e) {
          expect(e.error, expected);
          expect(e.stackTrace, isNotNull);
        }
      });
    });

    group('clearCredentials', () {
      test('completes when deleteAll on storage succeeded', () async {
        when(
          () => flutterSecureStorage.deleteAll(),
        ).thenAnswer((_) async => Future.value());

        expect(
          secureStorage.clearCredentials(),
          completes,
        );
      });

      test('throws WriteException when deleteAll on storage fails', () async {
        const expected = WriteException('error');
        when(
          () => flutterSecureStorage.deleteAll(),
        ).thenThrow(expected);

        try {
          await secureStorage.clearCredentials();
        } on StorageException catch (e) {
          expect(e.error, expected);
          expect(e.stackTrace, isNotNull);
        }
      });
    });
  });
}
