import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Themes', () {
    group('ThemeDataX', () {
      final log = <MethodCall>[];

      TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
          .setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );

      setUp(log.clear);

      testWidgets(
        'setStatusBarTheme calls setSystemUIOverlayStyle '
        'with color and brightness',
        (tester) async {
          ThemeData().setStatusBarTheme(
            color: Colors.black,
            brightness: Brightness.dark,
          );

          expect(tester.binding.microtaskCount, equals(1));

          await tester.idle();

          expect(
            log.single,
            isMethodCall(
              'SystemChrome.setSystemUIOverlayStyle',
              arguments: <String, dynamic>{
                'statusBarColor': Colors.black.value,
                'statusBarIconBrightness': 'Brightness.dark',
                'systemNavigationBarColor': null,
                'systemNavigationBarDividerColor': null,
                'systemStatusBarContrastEnforced': null,
                'statusBarBrightness': null,
                'systemNavigationBarIconBrightness': null,
                'systemNavigationBarContrastEnforced': null,
              },
            ),
          );
        },
      );

      testWidgets(
        'setSystemNavigationTheme calls setSystemUIOverlayStyle '
        'with color and brightness',
        (tester) async {
          ThemeData().setSystemNavigationTheme(
            color: Colors.black,
            brightness: Brightness.dark,
          );

          expect(tester.binding.microtaskCount, equals(1));

          await tester.idle();

          expect(
            log.single,
            isMethodCall(
              'SystemChrome.setSystemUIOverlayStyle',
              arguments: <String, dynamic>{
                'systemNavigationBarColor': Colors.black.value,
                'systemNavigationBarIconBrightness': 'Brightness.dark',
                'statusBarColor': null,
                'statusBarIconBrightness': null,
                'systemNavigationBarDividerColor': null,
                'systemStatusBarContrastEnforced': null,
                'statusBarBrightness': null,
                'systemNavigationBarContrastEnforced': null,
              },
            ),
          );
        },
      );
    });

    group('ThemeData', () {
      test('lightThemeData', () {
        final themeData = lightThemeData();

        expect(themeData.primaryColor, white);
        expect(themeData.shadowColor, lightGrey);
        expect(themeData.brightness, Brightness.light);
        expect(themeData.textTheme.headline1?.fontFamily, 'Oswald');
        expect(themeData.textTheme.bodyText1?.fontFamily, 'Oswald');
        expect(themeData.textTheme.subtitle1?.fontFamily, 'Oswald');
        expect(themeData.snackBarTheme.contentTextStyle?.fontFamily, 'Oswald');
      });

      test('darkThemeData', () {
        final themeData = darkThemeData();

        expect(themeData.primaryColor, black);
        expect(themeData.shadowColor, grey);
        expect(themeData.brightness, Brightness.dark);
        expect(themeData.textTheme.headline1?.fontFamily, 'Oswald');
        expect(themeData.textTheme.bodyText1?.fontFamily, 'Oswald');
        expect(themeData.textTheme.subtitle1?.fontFamily, 'Oswald');
        expect(themeData.snackBarTheme.contentTextStyle?.fontFamily, 'Oswald');
      });
    });
  });
}
