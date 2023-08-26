import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          fillColor: Colors.red,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: TextTheme(bodyLarge: GoogleFonts.actor()),
      brightness: Brightness.dark,
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
    );
  }
}
