import 'dart:math';
import 'dart:ui';

extension ColorFromHex on Color {
  static fromHex(String hex) {
    return Color(int.parse(hex, radix: 16));
  }
}

extension ColorToHex on Color {
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

extension ColorDistance on Color {
  /// Calculates the Euclidean distance between two colors in RGB color space
  double distanceTo(Color other) {
    //  black   = 0xFF000000 = 0 0 0
    //  blue    = 0xFF0000FF = 0 0 1
    //  green   = 0xFF00FF00 = 0 1 0
    //  cyan    = 0xFF00FFFF = 0 1 1
    //  red     = 0xFFFF0000 = 1 0 0
    //  magenta = 0xFFFF00FF = 1 0 1
    //  yellow  = 0xFFFFFF00 = 1 1 0
    //  white   = 0xFFFFFFFF = 1 1 1

    return sqrt(
      pow((r - other.r), 2) + pow((g - other.g), 2) + pow((b - other.b), 2),
    );
  }

  bool isClose(Color other, {double redLowerThreshold = 0.70}) {
    // new 0.5490196078431373 | 0.8156862745098039 | 0.8274509803921568
    // cur 0.0                | 1.0                | 1.0
    print("new ${other.r} ${other.g} ${other.b}");
    print("cur $r $g $b");
    var closeToR = r == 0 ? other.r < redLowerThreshold : other.r >= 0.50;
    var closeToG = g == 0 ? other.g < 0.70 : other.g >= 0.50;
    var closeToB = b == 0 ? other.b < 0.70 : other.b >= 0.50;
    return closeToR && closeToG && closeToB;
  }
}
