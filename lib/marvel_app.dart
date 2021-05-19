import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/dependency_injection.dart';
import 'package:marvel/router.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarvelApp extends StatelessWidget {
  const MarvelApp({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return buildDependencyInjection(
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
