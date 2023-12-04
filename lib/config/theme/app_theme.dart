import 'package:flutter/material.dart';
import 'package:history_app/config/theme/responsive.dart';

class AppTheme {

  static const Color primary =  Color(0xff00ACC1);
  static const Color secondary =  Color(0xffFFAB00);
  final Brightness colorMode;

  AppTheme({
    this.colorMode = Brightness.light
  });

  ThemeData getTheme(BuildContext context) => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.cyanAccent.shade700,
      primary: primary,
      secondary: secondary,
      brightness: colorMode
    ),

    textTheme: TextTheme(
      headlineMedium: const TextStyle(
        color: primary,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: Responsive(context).ip(1.65),
        fontWeight: FontWeight.w300
      )
    ),

    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xffF5F7F7),
      labelStyle: TextStyle(color: secondary),
      hintStyle: TextStyle(color: Colors.grey),
    ),

   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(primary),
      foregroundColor: const MaterialStatePropertyAll(Colors.white),
      textStyle: const MaterialStatePropertyAll(TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold
      )),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ))
    ),
   )
  );

}