import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/app/routes/routes.dart';
import 'package:marvel/home/view/home_page.dart';
import 'package:marvel/login/view/login_page.dart';

void main() {
  group('onGenerateAppViewPages', () {
    test('when authenticated returns HomePage', () {
      final pages =
          onGenerateAppViewPages(AuthenticationStatus.authenticated, []);
      expect(pages, [HomePage.page()]);
    });

    test('when unauthenticated returns LoginPage', () {
      final pages =
          onGenerateAppViewPages(AuthenticationStatus.unauthenticated, []);
      expect(pages, [LoginPage.page()]);
    });
  });
}
