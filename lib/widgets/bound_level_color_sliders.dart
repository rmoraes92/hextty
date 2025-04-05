import 'package:flutter/material.dart';
import 'package:hextty/logger.dart';
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

  List<ColorSlider> buildColorSliders() {
    var onChangedFunctions = [
      widget.onChangedThresholdRed,
      widget.onChangedThresholdGreen,
      widget.onChangedThresholdBlue,
    ];
    var thresholdColors = [widget.red, widget.green, widget.blue];
    List<ColorSlider> ret = [];
    for (final (idx, thresholdColor) in thresholdColors.indexed) {
      ret.add(
        ColorSlider(
          mode: ColorSliderMode.eightBits,
          color: thresholdColor.color,
          colorAlpha: 0.5,
          initialValue: switch (widget.mode) {
            BoundLevelColorSlidersMode.lowerBound => thresholdColor.lowerBound,
            BoundLevelColorSlidersMode.upperBound => thresholdColor.upperBound,
          },
          onChanged: (double value) {
            logger.t("_BoundLevelColorSlidersState - onChanged");
            //setState(() {
              //logger.t("_BoundLevelColorSlidersState - setState");
              onChangedFunctions[idx](value);
            //});
          },
        ),
      );
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    logger.t("_BoundLevelColorSlidersState - build");
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
          children: buildColorSliders(),
        ),
      ],
    );
  }
}
