// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:test/test.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

class _MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  const privateKey = 'privateKey';
  const publicKey = 'publicKey';

  late SecureStorage storage;
  late AuthenticationRepository authenticationRepository;

  group('AuthenticationRepository', () {
    setUp(() {
      storage = _MockSecureStorage();
      when(() => storage.privateKey()).thenAnswer((_) async => privateKey);
      when(() => storage.publicKey()).thenAnswer((_) async => publicKey);

      authenticationRepository = AuthenticationRepository(storage);
    });

    test('can be instantiated', () {
      expect(AuthenticationRepository(storage), isNotNull);
    });

    group('login', () {
      test('completes when secureStorage saveCredentials succeeded', () async {
        when(
          () => storage.saveCredentials(
            privateKey: privateKey,
            publicKey: publicKey,
          ),
        ).thenAnswer((_) async => Future.value());

        expect(
          authenticationRepository.login(
            privateKey: privateKey,
            publicKey: publicKey,
          ),
          completes,
        );
      });

      test('throws WriteException when secureStorage saveCredentials fails',
          () async {
        when(
          () => storage.saveCredentials(
            privateKey: any(named: 'privateKey'),
            publicKey: any(named: 'publicKey'),
          ),
        ).thenThrow(WriteException('error'));

        try {
          await authenticationRepository.login(
            privateKey: privateKey,
            publicKey: publicKey,
          );
        } catch (e) {
          expect(e, isA<StorageException>());
        }
      });
    });

    group('logout', () {
      test('completes when secureStorage clearCredentials succeeded', () async {
        when(
          () => storage.clearCredentials(),
        ).thenAnswer((_) async => Future.value());

        expect(
          authenticationRepository.logout(),
          completes,
        );
      });

      test('throws WriteException when secureStorage clearCredentials fails',
          () async {
        when(
          () => storage.clearCredentials(),
        ).thenThrow(WriteException('error'));

        try {
          await authenticationRepository.logout();
        } catch (e) {
          expect(e, isA<StorageException>());
        }
      });
    });

    group('user', () {
      test(
        'returns expected when unauthenticated and login',
        () async {
          when(
            () => storage.saveCredentials(
              privateKey: privateKey,
              publicKey: publicKey,
            ),
          ).thenAnswer((_) async => Future.value());

          unawaited(
            expectLater(
              authenticationRepository.user,
              emitsInOrder(<bool>[true]),
            ),
          );

          await authenticationRepository.login(
            privateKey: privateKey,
            publicKey: publicKey,
          );
        },
        timeout: const Timeout(Duration(milliseconds: 500)),
      );

      test(
        'throws Exception and keeps unauthenticated when login fails',
        () async {
          when(
            () => storage.saveCredentials(
              privateKey: privateKey,
              publicKey: publicKey,
            ),
          ).thenThrow(WriteException('error'));

          unawaited(
            expectLater(
              authenticationRepository.user,
              emitsInOrder(
                <bool>[
                  false,
                ],
              ),
            ),
          );

          try {
            await authenticationRepository.login(
              privateKey: privateKey,
              publicKey: publicKey,
            );
          } catch (e) {
            expect(e, isA<StorageException>());
          }
        },
        timeout: const Timeout(Duration(milliseconds: 500)),
      );

      test(
        'returns expected when authenticated and logout',
        () async {
          when(
            () => storage.saveCredentials(
              privateKey: privateKey,
              publicKey: publicKey,
            ),
          ).thenAnswer((_) async => Future.value());

          when(
            () => storage.clearCredentials(),
          ).thenAnswer((_) async => Future.value());

          unawaited(
            expectLater(
              authenticationRepository.user,
              emitsInOrder(
                <bool>[
                  true,
                  false,
                ],
              ),
            ),
          );

          await authenticationRepository.login(
            privateKey: privateKey,
            publicKey: publicKey,
          );

          await authenticationRepository.logout();
        },
        timeout: const Timeout(Duration(milliseconds: 500)),
      );

      test(
        'throws Exception and keeps authenticated when logout fails',
        () async {
          when(
            () => storage.saveCredentials(
              privateKey: privateKey,
              publicKey: publicKey,
            ),
          ).thenAnswer((_) async => Future.value());

          when(
            () => storage.clearCredentials(),
          ).thenThrow(WriteException('error'));

          unawaited(
            expectLater(
              authenticationRepository.user,
              emitsInOrder(<bool>[
                true,
              ]),
            ),
          );

          try {
            await authenticationRepository.logout();
          } catch (e) {
            expect(e, isA<StorageException>());
          }
        },
        timeout: const Timeout(Duration(milliseconds: 500)),
      );
    });

    test(
      'dispose completes normally',
      () {
        expect(authenticationRepository.dispose(), completes);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
