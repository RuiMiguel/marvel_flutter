// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:api_client/api_client.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:character_repository/character_repository.dart';
import 'package:comic_repository/comic_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel/app/app.dart';
import 'package:marvel/bootstrap.dart';
import 'package:secure_storage/secure_storage.dart';

void main() {
  bootstrap(() async {
    const baseUrl = 'gateway.marvel.com:443';

    final dio = Dio(
      BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );
    final loggingInterceptor = LoggingInterceptor(logEnabled: true);
    final apiClient = DioApiClient(
      dio: dio,
      loggingInterceptor: loggingInterceptor,
    );

    const secureStorage = SecureStorage();

    await dotenv.load();

    final privateKey = dotenv.env['PRIVATE_KEY'];
    final publicKey = dotenv.env['PUBLIC_KEY'];

    if (privateKey != null && publicKey != null) {
      await secureStorage.saveCredentials(
        privateKey: privateKey,
        publicKey: publicKey,
      );
    }

    final security = Security(
      storage: secureStorage,
    );

    final characterService = CharacterService(
      baseUrl,
      apiClient: apiClient,
      security: security,
    );
    final comicService = ComicService(
      baseUrl,
      apiClient: apiClient,
      security: security,
    );

    final authenticationRepository = AuthenticationRepository(secureStorage);
    final characterRepository = CharacterRepository(characterService);
    final comicRepository = ComicRepository(comicService);

    return App(
      authenticationRepository: authenticationRepository,
      characterRepository: characterRepository,
      comicRepository: comicRepository,
    );
  });
}
