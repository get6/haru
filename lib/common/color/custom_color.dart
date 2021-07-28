import 'package:flutter/material.dart';

// 해당 프로젝트 주요 색상
Color main_color = const Color(0xFFA5FFD6);
// Color main_color = const Color(0xFF3ACBE8);
Color button_color = const Color(0xFF3ACBE8);
Color accent_color = const Color(0xFFFFA5CE);
Color empty_color = const Color(0xFFF8F8F8);
Color timer_background_color = Colors.blue[50]!;
Color timer_button_color = const Color.fromRGBO(72, 74, 126, 1);

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = [.05];
  final Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (var i = 0; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1);
  }

  return MaterialColor(color.value, swatch);
}

MaterialColor createPrimaryColor(Color? color) {
  return createMaterialColor(color ?? main_color);
}

MaterialColor createAccentColor(Color? color) {
  return createMaterialColor(color ?? accent_color);
}

enum neumorphicColor {
  primary,
  highlight,
  accent,
  cursor,
  canvas,
  divider,
  error,
  background
}

final Map<neumorphicColor, Color> neumorphicTheme = {
  // Hour hand.
  neumorphicColor.primary: Colors.grey[800]!,
  // Minute hand.
  neumorphicColor.highlight: Colors.grey[800]!,
  // Second hand.
  neumorphicColor.accent: Colors.red[800]!,
  // Tick color
  neumorphicColor.cursor: Colors.grey[900]!,
  // Shadow color
  neumorphicColor.canvas: Colors.grey[500]!,
  // Inner shadow color
  neumorphicColor.divider: Colors.grey[400]!,
  // Icon color:
  neumorphicColor.error: Colors.grey[800]!.withOpacity(0.1),
  neumorphicColor.background: Colors.grey[300]!,
};
