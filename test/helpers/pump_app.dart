// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication_repository/authentication_repository.dart';
import 'package:character_repository/character_repository.dart';
import 'package:comic_repository/comic_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class _MockDefaultCacheManager extends Mock implements DefaultCacheManager {}

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockCharacterRepository extends Mock implements CharacterRepository {}

class _MockComicRepository extends Mock implements ComicRepository {}

class _MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    CacheManager? cacheManager,
    AuthenticationRepository? authenticationRepository,
    CharacterRepository? characterRepository,
    ComicRepository? comicRepository,
    AuthenticationBloc? authenticationBloc,
  }) async {
    await pumpWidget(
      Provider.value(
        value: cacheManager ?? _MockDefaultCacheManager(),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value:
                  authenticationRepository ?? _MockAuthenticationRepository(),
            ),
            RepositoryProvider.value(
              value: characterRepository ?? _MockCharacterRepository(),
            ),
            RepositoryProvider.value(
              value: comicRepository ?? _MockComicRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: authenticationBloc ?? _MockAuthenticationBloc(),
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: widget,
            ),
          ),
        ),
      ),
    );

    await pump();
  }
}
