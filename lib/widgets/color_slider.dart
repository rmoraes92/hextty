import 'package:flutter/material.dart';
import 'package:hextty/constants.dart';
import 'package:hextty/logger.dart';
import 'package:hextty/services/color_extensions.dart';

enum ColorSliderMode { eightBits, percentage }

class ColorSlider extends StatefulWidget {
  final ColorSliderMode mode;
  final Color color;
  final double colorAlpha;
  final double initialValue;
  final void Function(double) onChanged;
  const ColorSlider({
    super.key,
    required this.mode,
    required this.color,
    required this.colorAlpha,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<ColorSlider> createState() => ColorSliderState();
}

class ColorSliderState extends State<ColorSlider> {
  late double sliderValue;
  late double max;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;
    max = switch (widget.mode) {
      ColorSliderMode.eightBits => Settings.colorChannelUpperBound,
      ColorSliderMode.percentage => 100,
    };
  }

  @override
  Widget build(BuildContext context) {
    logger.t("ColorSliderState - build - ${widget.color.toHexString()}");
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: widget.color,
        inactiveTrackColor: widget.color.withValues(alpha: widget.colorAlpha),
        thumbColor: widget.color,
      ),
      child: Slider(
        value: sliderValue,
        min: 0,
        max: max,
        divisions: max.toInt(),
        label: sliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            sliderValue = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
