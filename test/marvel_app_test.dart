import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/marvel_app.dart';
import 'package:marvel/ui/auth_screen.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:marvel/ui/login/login_screen.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('MarvelApp', () {
    late SharedPreferences sharedPreferences;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
    });

    testWidgets('renders WeatherAppView', (tester) async {
      await tester.pumpWidget(MarvelApp(
        prefs: sharedPreferences,
      ));
      expect(find.byType(AuthScreen), findsOneWidget);
    });
  });

  group('AuthScreen', () {
    late SharedPreferences sharedPreferences;

    testWidgets('renders LoginScreen when user unauthenticated',
        (tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(MarvelApp(
        prefs: await SharedPreferences.getInstance(),
      ));
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('renders HomeScreen when user authenticated', (tester) async {
      var fakePrivateKey = "FAKE_PRIVATE_KEY";
      var fakePublicKey = "FAKE_PUBLIC_KEY";
      SharedPreferences.setMockInitialValues(
        {
          DatastoreManager.PRIVATE_KEY: fakePrivateKey,
          DatastoreManager.PUBLICK_KEY: fakePublicKey,
        },
      );

      await tester.pumpWidget(MarvelApp(
        prefs: await SharedPreferences.getInstance(),
      ));
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
