import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(

    scaffoldBackgroundColor: Colors.white,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      primary: Colors.black,
      onPrimary: Colors.white,
    ),

    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black87,
      toolbarHeight: 80,
      
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
     style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.white),
      mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        )
      )
     ) 
    ),

  );
}