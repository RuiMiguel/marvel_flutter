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
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:marvel/app/app.dart';
import 'package:marvel/bootstrap.dart';
import 'package:secure_storage/secure_storage.dart';

void main() {
  bootstrap(() async {
    const secureStorage = SecureStorage();
    final security = Security(
      storage: secureStorage,
    );

    const baseUrl = 'gateway.marvel.com:443';

    final dio = Dio(
      BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
      ),
    );
    final authInterceptor = AuthInterceptor(security: security);
    final apiClient = DioApiClient(
      dio: dio,
      authInterceptor: authInterceptor,
    );

    final characterService = CharacterService(
      baseUrl,
      apiClient: apiClient,
    );
    final comicService = ComicService(
      baseUrl,
      apiClient: apiClient,
    );

    final authenticationRepository = AuthenticationRepository(secureStorage);
    final characterRepository = CharacterRepository(characterService);
    final comicRepository = ComicRepository(comicService);
    final defaultCacheManager = DefaultCacheManager();

    return App(
      authenticationRepository: authenticationRepository,
      characterRepository: characterRepository,
      comicRepository: comicRepository,
      cacheManager: defaultCacheManager,
    );
  });
}
