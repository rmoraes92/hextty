import 'dart:ui';

class ColorThreshold {
  Color color;
  double upperBound;
  double lowerBound;
  ColorThreshold({
    required this.color,
    this.upperBound = 125.0,
    this.lowerBound = 178.0,
  });

  void setUpperBound(double value) {
    upperBound = value;
  }

  void setLowerBound(double value) {
    lowerBound = value;
  }
}
