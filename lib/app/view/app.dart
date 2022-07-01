// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:character_repository/character_repository.dart';
import 'package:comic_repository/comic_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marvel/home/home.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/styles/themes.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.characterRepository,
    required this.comicRepository,
  });

  final CharacterRepository characterRepository;
  final ComicRepository comicRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: characterRepository,
        ),
        RepositoryProvider.value(
          value: comicRepository,
        )
      ],
      child: const AppView(),
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
      home: const HomePage(),
    );
  }
}
