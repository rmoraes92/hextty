import 'package:flutter/material.dart';
import 'package:hextty/models.dart';
import 'package:hextty/widgets/color_slider.dart';

enum BoundLevelColorSlidersMode { lowerBound, upperBound }

class BoundLevelColorSliders extends StatefulWidget {
  final BoundLevelColorSlidersMode mode;

  final ColorThreshold red;
  final ColorThreshold green;
  final ColorThreshold blue;

  final void Function(double) onChangedThresholdRed;
  final void Function(double) onChangedThresholdGreen;
  final void Function(double) onChangedThresholdBlue;

  const BoundLevelColorSliders({
    super.key,
    required this.mode,
    required this.red,
    required this.green,
    required this.blue,
    required this.onChangedThresholdRed,
    required this.onChangedThresholdGreen,
    required this.onChangedThresholdBlue,
  });
  @override
  State<BoundLevelColorSliders> createState() => _BoundLevelColorSlidersState();
}

class _BoundLevelColorSlidersState extends State<BoundLevelColorSliders> {
  late double initialValueRed;
  late double initialValueGreen;
  late double initialValueBlue;

  @override
  void initState() {
    super.initState();
    switch (widget.mode) {
      case BoundLevelColorSlidersMode.lowerBound:
        {
          initialValueRed = widget.red.lowerBound;
          initialValueGreen = widget.green.lowerBound;
          initialValueBlue = widget.blue.lowerBound;
        }
      case BoundLevelColorSlidersMode.upperBound:
        {
          initialValueRed = widget.red.upperBound;
          initialValueGreen = widget.green.upperBound;
          initialValueBlue = widget.blue.upperBound;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        switch (widget.mode) {
          BoundLevelColorSlidersMode.lowerBound => Text(
            "Lower Bound Threshold",
          ),
          BoundLevelColorSlidersMode.upperBound => Text(
            "Upper Bound Threshold",
          ),
        },
        Row(
          // Equivalent to CSS justify-content: space-around
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Equivalent to CSS align-items: center
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorSlider(
              mode: ColorSliderMode.eightBits,
              color: Colors.red,
              colorAlpha: 0.5,
              initialValue: initialValueRed,
              onChanged: (double value) {
                widget.onChangedThresholdRed(value);
              },
            ),
            ColorSlider(
              mode: ColorSliderMode.eightBits,
              color: Colors.green,
              colorAlpha: 0.5,
              initialValue: initialValueGreen,
              onChanged: (double value) {
                setState(() {
                  initialValueGreen = value;
                });
                widget.onChangedThresholdGreen(value);
              },
            ),
            ColorSlider(
              mode: ColorSliderMode.eightBits,
              color: Colors.blue,
              colorAlpha: 0.5,
              initialValue: initialValueBlue,
              onChanged: (double value) {
                setState(() {
                  initialValueBlue = value;
                });
                widget.onChangedThresholdBlue(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
