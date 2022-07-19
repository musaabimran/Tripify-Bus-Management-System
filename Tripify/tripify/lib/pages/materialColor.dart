import 'package:flutter/material.dart';

// making afunction that will help in building the custom colors to use in primary swatch
// basicallay in swap the main color is taken and then shades are used accordingly
//  but our custom is not there so making a material color to use it

// a function returning the material color eith taking a color the hexa value
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  // the components of red green and blue
  final int r = color.red, g = color.green, b = color.blue;

  // for shades
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

// making the color shades
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  //returning the color to use
  return MaterialColor(color.value, swatch);
}
