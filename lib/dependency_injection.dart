import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/authentication/authentication_bloc.dart';
import 'package:marvel/bloc/comics/comics_bloc.dart';
import 'package:marvel/bloc/login/login_bloc.dart';
import 'package:marvel/cubit/underconstruction_cubit.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

MultiProvider buildDependencyInjection({
  required SharedPreferences preferences,
  required Widget widget,
}) {
  return _buildDataInjection(
    preferences: preferences,
    widget: _buildBlocInjection(
      widget: widget,
    ),
  );
}

MultiRepositoryProvider _buildDataInjection({
  required SharedPreferences preferences,
  required Widget widget,
}) {
  final _baseUrl = "gateway.marvel.com:443";
  final _logEnabled = true;
  final _connectTimeout = 30000;
  final _receiveTimeout = 30000;

  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => preferences,
      ),
      RepositoryProvider(
        create: (context) =>
            DatastoreManager(RepositoryProvider.of<SharedPreferences>(context)),
      ),
      RepositoryProvider(
        create: (context) {
          var options = BaseOptions(
            connectTimeout: _connectTimeout,
            receiveTimeout: _receiveTimeout,
          );
          return Dio(options)..interceptors.add(LogginInterceptor(_logEnabled));
        },
      ),
      RepositoryProvider(
        create: (context) {
          var _datastore = context.read<DatastoreManager>();

          return CharacterApiClient(
            _baseUrl,
            privateKey: _datastore.getPrivateKey(),
            publicKey: _datastore.getPublicKey(),
            logEnabled: _logEnabled,
          );
        },
      ),
      RepositoryProvider(
        create: (context) {
          var _datastore = context.read<DatastoreManager>();

          return ComicsApiClient(
            _baseUrl,
            privateKey: _datastore.getPrivateKey(),
            publicKey: _datastore.getPublicKey(),
            dio: context.read<Dio>(),
          );
        },
      ),
      RepositoryProvider<ComicsRepository>(
        create: (context) =>
            ComicsDataRepository(context.read<ComicsApiClient>()),
      ),
    ],
    child: widget,
  );
}

MultiBlocProvider _buildBlocInjection({
  required Widget widget,
}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthenticationBloc(
            RepositoryProvider.of<DatastoreManager>(context)),
      ),
      BlocProvider(
        create: (context) => LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          datastore: RepositoryProvider.of<DatastoreManager>(context),
        ),
      ),
      BlocProvider(
        create: (context) => ComicsBloc(
          RepositoryProvider.of<ComicsRepository>(context),
        ),
      ),
      BlocProvider(
        create: (context) => UnderConstructionCubit(),
      ),
    ],
    child: widget,
  );
}
