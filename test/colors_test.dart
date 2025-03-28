import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hextty/color_entry.dart';
import 'package:hextty/color_extensions.dart';

void main() {
  group('foo function tests', () {
    test('foo should return "bar"', () {
      // Arrange (setup)
      // Act (call the function)
      var colorEntry = ColorFromHex.fromHex("8cd0d3");
      var res = TerminalColors.cyan.isClose(colorEntry);
      // Assert (verify the expected outcome)
      expect(res, equals(true));
    });
  });
}
