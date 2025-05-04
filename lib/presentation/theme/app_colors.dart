import 'package:flutter/material.dart';

class AppColors {
  static const white = Color(0xFFF6F6F6);
  static const yellow = Color(0xFFCBA50C);
  static const black = Color(0xFF1E1E1E);
  static const green = Color(0xFF083D05);
  static const accent = Color(0x1F299E8D);
  static const transparent = Color(0x00000000);

  /// Creates a Color object from a valid hex color string.
  static Color fromHex(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('FF');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
