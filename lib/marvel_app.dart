import 'package:flutter/material.dart';
import 'package:marvel/providers.dart';
import 'package:marvel/router.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MarvelApp extends StatelessWidget {
  const MarvelApp({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return buildMultiProvider(
      preferences: prefs,
      widget: MaterialApp(
        home: AuthScreen(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: lightThemeData(),
        darkTheme: darkThemeData(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
