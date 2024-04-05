//Definicion de los temas de estilo de lapp
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //constante de color primario
  static const primaryColor = Color.fromARGB(255, 1, 79, 134); 
  //Constante de color secunadrio
  static const secondaryColor = Color.fromARGB(255, 0, 100, 180); 
  //Constante de color terciario
  static const tertiaryColor = Color.fromARGB(255, 0, 200, 100); 
  //Constante de color cuarteario
  static const quaternaryColor = Color.fromARGB(255, 0, 120, 60); 
  //Constante de color de fondo
  static const backColor = Color.fromARGB(255, 220, 240, 255); 
  
  //constante de temas
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: backColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      titleTextStyle: GoogleFonts.bebasNeue(
        color: const Color.fromARGB(255, 0, 0, 0),
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
          backgroundColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 255, 255, 255),
          ),
          foregroundColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 0, 0, 0),
          ),
          textStyle: WidgetStateProperty.all(GoogleFonts.pacifico(
            fontSize: 25.0,
          ))),
    ),
    textTheme: TextTheme(
      //titulos muy grandes
      headlineLarge: GoogleFonts.bebasNeue(
        color: primaryColor,
        fontSize: 50.5,
        fontWeight: FontWeight.w500,
        decorationStyle: TextDecorationStyle.wavy,
        decorationThickness: 1.0,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: secondaryColor,
        fontSize: 21.5,
        fontWeight: FontWeight.bold,
      ),
      //estilo para texto muy pequeño
      bodySmall: GoogleFonts.bebasNeue(
        color: secondaryColor, 
        fontSize: 16.0
        ),
      bodyMedium: GoogleFonts.bebasNeue(
        color: quaternaryColor,
        fontSize: 20.0,
      ),
      bodyLarge: GoogleFonts.bebasNeue(
        color: primaryColor,
        fontSize: 24.0,
      ),
    ),
  );
}