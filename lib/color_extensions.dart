import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hextty/logger.dart';

extension ColorFactory on Color {
  static fromHex(String hex) {
    return Color(int.parse(hex, radix: 16));
  }
}

extension ColorToStringHex on Color {
  // Method 1: Full hex with alpha
  String toHexString() {
    return '#${toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  // Method 2: Hex without alpha (if fully opaque)
  String toHexStringRGB() {
    return '#${(toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  // Method 3: Detailed conversion with optional alpha
  String toHexStringDetailed({bool includeAlpha = false}) {
    if (includeAlpha) {
      return '#${toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    }
    return '#${(toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

extension ColorFindClosest on Color {
  Color findClosest(
    List<Color> colorList, {
    double redLowerThreshold = 0.70,
    double greenLowerThreshold = 0.70,
    double blueLowerThreshold = 0.70,
    double redUpThreshold = 0.50,
    double greenUpThreshold = 0.50,
    double blueUpThreshold = 0.50,
  }) {
    logger.t("Color $r $g $b");
    logger.t("Red   Lower Threshold $redLowerThreshold");
    logger.t("Green Lower Threshold $greenLowerThreshold");
    logger.t("Blue  Lower Threshold $blueLowerThreshold");
    logger.t("Red   Upper Threshold $redUpThreshold");
    logger.t("Green Upper Threshold $greenUpThreshold");
    logger.t("Blue  Upper Threshold $blueUpThreshold");
    for (var colorEntry in colorList) {
      var closeToR =
          colorEntry.r == 0 ? r < redLowerThreshold : r >= redUpThreshold;
      var closeToG =
          colorEntry.g == 0 ? g < greenLowerThreshold : g >= greenUpThreshold;
      var closeToB =
          colorEntry.b == 0 ? b < blueLowerThreshold : b >= blueUpThreshold;
      if (closeToR && closeToG && closeToB) {
        return colorEntry;
      }
    }
    throw Exception("match not found");
  }
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
}
