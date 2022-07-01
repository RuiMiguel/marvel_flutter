import 'package:flutter/material.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/home/home.dart';
import 'package:marvel/login/login.dart';
import 'package:marvel/splash/splash_page.dart';

List<Page> onGenerateAppViewPages(
  AuthenticationStatus state,
  List<Page> pages,
) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [HomePage.page()];
    case AuthenticationStatus.unauthenticated:
      return [LoginPage.page()];
    case AuthenticationStatus.authenticating:
      return [SplashPage.page()];
  }
}
