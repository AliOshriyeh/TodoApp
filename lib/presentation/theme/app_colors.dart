import 'package:flutter/material.dart';

class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const red = Color(0xFFB60E1D);
  static const green = Color(0xFF4CA23E);
  static const transparent = Color(0x00000000);
  static const surface = white;

  static const primary = Color(0xFF6750A4);
  static const primaryAccent = Color(0xFF7E67C1);
  static const primaryDeep = Color(0xFF4F378B);
  static const secondary = Color(0xFF958DA5);
  static const secondaryAccent = Color(0xFFE8DEF8);
  static const tertiary = Color(0xFFB58392);
  static const tertiaryAccent = Color(0xFFFFD8E4);
  static const textDark = Color(0xFF222222);
  static const textLight = Color(0xFFFFFFFD);
  static const lightOrange = Color(0xFFFFDFDE);

  static const grey = Color(0xFF737373);
  static const brightGrey = Color(0xFFA3A3A3);
  static const lightGray = Color(0xFFE8E8E8);
  static const success = Color(0xFF32BC32);
  static const info = Color(0xFF3478F6);
  static const warn = Color(0xFFFFB600);
  static const error = Color(0xFFFF3A30);
  static const warning = Color.fromARGB(220, 160, 4, 4);

  /// Creates a Color object from a valid hex color string.
  static Color fromHex(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('FF');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
