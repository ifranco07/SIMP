import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Constantes de colores
  static const Color primaryColor = Color.fromARGB(255, 1, 79, 134);
  static const Color secondaryColor = Color.fromARGB(255, 0, 100, 180);
  static const Color tertiaryColor = Color.fromARGB(255, 0, 200, 100);
  static const Color quaternaryColor = Color.fromARGB(255, 0, 120, 60);
  static const Color backColor = Color.fromARGB(0, 255, 255, 255);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: backColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 25.8,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 35.0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => const Color.fromARGB(255, 255, 255, 255)),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => const Color.fromARGB(255, 0, 0, 0)),
        textStyle:
            MaterialStateProperty.resolveWith((states) => const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 25.0,
                )),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        color: primaryColor,
        fontSize: 50.5,
        fontWeight: FontWeight.w500,
        decorationStyle: TextDecorationStyle.wavy,
        decorationThickness: 1.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        color: secondaryColor,
        fontSize: 21.5,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Montserrat',
        color: secondaryColor,
        fontSize: 16.0,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: quaternaryColor,
        fontSize: 20.0,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: primaryColor,
        fontSize: 24.0,
      ),
    ),
  );
}
