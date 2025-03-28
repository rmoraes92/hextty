import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:hextty/color_extensions.dart';

/// Returns the closest base color to the given color
Color findClosestBaseColor(Color color) {
  return baseColors.reduce((closest, current) {
    return color.distanceTo(closest) < color.distanceTo(current)
        ? closest
        : current;
  });
}

class TerminalColors {
  static final Color black = Color(0xFF000000);
  static final Color red = Color(0xFFFF0000);
  static final Color green = Color(0xFF00FF00);
  static final Color yellow = Color(0xFFFFFF00);
  static final Color blue = Color(0xFF0000FF);
  static final Color magenta = Color(0xFFFF00FF);
  static final Color cyan = Color(0xFF00FFFF);
  static final Color white = Color(0xFFFFFFFF);
  static final List<Color> list = [
    black,
    red,
    green,
    yellow,
    blue,
    magenta,
    cyan,
    white,
  ];

  static Color findClosest(
    Color color, {
    double redLowerThreshold = 0.70,
    double greenLowerThreshold = 0.70,
    double blueLowerThreshold = 0.70,
  }) {
    print("redLowerThreshold $redLowerThreshold");
    print("greenLowerThreshold $greenLowerThreshold");
    print("blueLowerThreshold $blueLowerThreshold");
    for (var tcolor in list) {
      var closeToR =
          tcolor.r == 0 ? color.r < redLowerThreshold : color.r >= 0.50;
      var closeToG =
          tcolor.g == 0 ? color.g < greenLowerThreshold : color.g >= 0.50;
      var closeToB =
          tcolor.b == 0 ? color.b < blueLowerThreshold : color.b >= 0.50;
      if (closeToR && closeToG && closeToB) {
        return tcolor;
      }
    }
    throw Exception("match not found");
  }
}

class ColorEntry {
  String hex;
  late String hexTty;
  ColorEntry(this.hex);

  String getTtyVersion() {
    var c = Color(int.parse(hex, radix: 16));
    return findClosestBaseColor(c).toHexString();
  }
}

final List<Color> baseColors = [
  Color(0xFF000000), // Black
  Color(0xFFFFFFFF), // White
  Color(0xFFFF0000), // Red
  Color(0xFF00FF00), // Green
  Color(0xFFFFFF00), // Yellow
  Color(0xFF0000FF), // Blue
  Color(0xFFFF00FF), // Magenta
  Color(0xFF00FFFF), // Cyan
];
