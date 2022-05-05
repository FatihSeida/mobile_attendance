import 'package:flutter/material.dart';

class AppColor {
  //NEUTRAL
  static const MaterialColor bodyColor = MaterialColor(
    _bodyColorValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFAFAFA),
      200: Color(0xFFE1E1E1),
      300: Color(0xFFC7C7C7),
      400: Color(0xFFAEAEAE),
      500: Color(0xFF949494),
      600: Color(0xFF787878),
      700: Color(0xFF5c5c5c),
      800: Color(0xFF404040),
      900: Color(0xFF242424),
    },
  );
  static const int _bodyColorValue = 0xFF242424;

  //ACCENT
  static const Color errorColor = Color(0xFFD95952); //Danger - Use for errors
  static const Color successColor = Color(0xFF31B76A); //Succes - Use for Succes
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color bgPageColor = Color(0xFFE5E5E5);

  static const Color weakColor =
      Color(0xFFBDBDBD); //Weak - Use for secondary text
  static const Color weak2Color =
      Color(0xFFF6F4F4); //Weak - Use for secondary text

  //GRADIENT
  static const LinearGradient gradient1 = LinearGradient(colors: [
    Color(0XFFFF8D00),
    Color(0XFFFF6900),
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static const MaterialColor primary = MaterialColor(
    _primary,
    <int, Color>{
      50: Color(0xFFD9D9D9),
      100: Color(0xFFEFF1FF),
      200: Color(0xFFBEC4E0),
      300: Color(0xFFA8B0D5),
      400: Color(0xFF939DCB),
      500: Color(_primary),
      600: Color(0xFF6775B6),
      700: Color(0xFF5157AF),
      800: Color(0xFF3C4EA1),
      900: Color(0xFF263A96),
    },
  );
  static const int _primary = 0xFF263A96;

  static const MaterialColor neutral = MaterialColor(
    _neutral,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFF8F8F8),
      200: Color(0xFFBEC4E0),
      300: Color(0xFFB3B3B3),
      400: Color(0xFF999999),
      500: Color(0xFF666666),
      600: Color(0xFF4D4D4D),
      700: Color(0xFF333333),
      800: Color(0xFF1A1A1A),
      900: Color(_neutral),
    },
  );
  static const int _neutral = 0xFF000000;

  static const MaterialColor secondaryColor = MaterialColor(
    _secondaryColorValue,
    <int, Color>{
      100: Color(0xFFFFEAE6),
      200: Color(0xFFFFC0B3),
      300: Color(0xFFFFAB99),
      400: Color(0xFFFF9780),
      500: Color(0xFFFF8266),
      600: Color(0xFFFF6D4D),
      700: Color(0xFFFF5833),
      800: Color(0xFFFF431A),
      900: Color(_secondaryColorValue),
    },
  );
  static const int _secondaryColorValue = 0xFFFF2E00;
}
