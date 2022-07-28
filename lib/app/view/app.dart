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
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/splash/splash_page.dart';
import 'package:marvel/styles/themes.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
    required CharacterRepository characterRepository,
    required ComicRepository comicRepository,
    required CacheManager cacheManager,
  })  : _authenticationRepository = authenticationRepository,
        _characterRepository = characterRepository,
        _comicRepository = comicRepository,
        _cacheManager = cacheManager;

  final AuthenticationRepository _authenticationRepository;
  final CharacterRepository _characterRepository;
  final ComicRepository _comicRepository;
  final CacheManager _cacheManager;

  @override
  Widget build(BuildContext context) {
    return Provider<CacheManager>.value(
      value: _cacheManager,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: _authenticationRepository,
          ),
          RepositoryProvider.value(
            value: _characterRepository,
          ),
          RepositoryProvider.value(
            value: _comicRepository,
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                authenticationRepository: _authenticationRepository,
              ),
              lazy: false,
            ),
          ],
          child: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashPage(),
    );
  }
}
