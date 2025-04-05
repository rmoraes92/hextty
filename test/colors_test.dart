import 'package:flutter_test/flutter_test.dart';
import 'package:hextty/services/color_extensions.dart';

void main() {
  group('finding closest colors', () {
    test('8cd0d3 is close to cyan', () {
      var colorInput = ColorFactory.fromHex("8cd0d3");
      var closestColor = colorInput.findClosest(TerminalColors.list);
      expect(closestColor, equals(TerminalColors.cyan));
    });
  });
}
