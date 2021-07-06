import 'package:flutter/material.dart';

// 해당 프로젝트 주요 색상
Color main_color = const Color(0xFFA5FFD6);

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = [.05];
  final Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (var i = 0; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1);
  });

  return MaterialColor(color.value, swatch);
}

MaterialColor createPrimaryColor(Color? color) {
  return createMaterialColor(color ?? main_color);
}
