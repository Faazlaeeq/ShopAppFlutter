import 'package:flutter/material.dart';

class ThemeSettings {
  late int blackPrimaryValue;
  late MaterialColor primaryBlack;
  late ThemeData darkTheme;

  ThemeSettings() {
    blackPrimaryValue = 0xFF000000;
    primaryBlack = MaterialColor(blackPrimaryValue, <int, Color>{
      50: const Color(0xFF000000),
      100: const Color(0xFF000000),
      200: const Color(0xFF000000),
      300: const Color(0xFF000000),
      400: const Color(0xFF000000),
      500: Color(blackPrimaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    });

    darkTheme = ThemeData(
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      primarySwatch: primaryBlack,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
          primary: Colors.blue,
          secondary: Colors.white,
          background: Colors.black,
          onBackground: Colors.black),
    );
  }
}
