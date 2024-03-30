import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF000000),
  brightness: Brightness.dark,
  secondaryHeaderColor: const Color(0xFFFFFFFF),
  shadowColor: Colors.black.withOpacity(0.4),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color:Color(0xFFFFFFFF)),
    titleSmall: TextStyle(color: Color(0xFF000000)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black, selectedItemColor: ColorResources.themeDarkBackgroundColor),
);
