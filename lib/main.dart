import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/marvel_app.dart';
import 'package:marvel/ui/commons/bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  Bloc.observer = CustomBlocObserver();
  runApp(MarvelApp(
    prefs: prefs,
  ));
}
