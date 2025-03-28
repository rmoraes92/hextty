import 'package:flutter/material.dart';

class ColorPreview extends StatelessWidget {
  final String hexColor;
  final double size;
  final BoxShape shape;

  const ColorPreview({
    super.key,
    required this.hexColor,
    this.size = 40.0,
    required this.shape,
  });

  @override
  Widget build(BuildContext context) {
    // Convert hex color string to Color
    final Color color = Color(
      int.parse(hexColor.replaceFirst('#', ''), radix: 16) + 0xFF000000,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: shape,
        border: Border.all(color: Colors.black12, width: 1),
      ),
    );
  }
}
