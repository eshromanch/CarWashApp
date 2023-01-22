import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Color(0xFFD62426),
  secondaryHeaderColor: Color(0xFF1ED7AA),
  //disabledColor: Color(0xFFBABFC4),
  disabledColor: Color(0xFF000000),
  backgroundColor: Color(0xFFF3F3F3),
  errorColor: Color(0xFFE84D4F),
  brightness: Brightness.light,
  accentColor: Color(0xFF008037),
  hintColor: Color(0xFF9F9F9F),
  cardColor: Colors.white,


  colorScheme: ColorScheme.light(primary: Color(0xFF008037)),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Color(0xFF008037))),
);


