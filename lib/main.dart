import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hextty/services/color_extensions.dart';
import 'package:hextty/widgets/color_preview.dart';
import 'package:hextty/logger.dart';
import 'package:hextty/models.dart';
import 'package:hextty/themes.dart';
import 'package:hextty/widgets/bound_level_color_sliders.dart';
import 'package:hextty/widgets/color_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: NeoBrutalistTheme.darkTheme,
      home: const MyHomePage(title: 'hextty'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorThreshold thresholdColorRed = ColorThreshold(color: Colors.red);
  ColorThreshold thresholdColorGreen = ColorThreshold(color: Colors.green);
  ColorThreshold thresholdColorBlue = ColorThreshold(color: Colors.blue);

  List<String> colors = [];

  final TextEditingController _textController = TextEditingController();
  void _parseTextToList() {
    // Split the text into lines, removing any empty lines
    setState(() {
      colors =
          _textController.text
              .split('\n')
              .where((line) => line.trim().isNotEmpty)
              .toList();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.t("_MyHomePageState - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            BoundLevelColorSliders(
              mode: BoundLevelColorSlidersMode.upperBound,
              red: thresholdColorRed,
              green: thresholdColorGreen,
              blue: thresholdColorBlue,
              onChangedThresholdRed: (double newUpperBound) {
                logger.t("_MyHomePageState - onChangedThresholdRed - uppper");
                setState(() {
                  thresholdColorRed.upperBound = newUpperBound;
                });
              },
              onChangedThresholdGreen: (double newUpperBound) {
                logger.t("_MyHomePageState - onChangedThresholdGreen");
                setState(() {
                  thresholdColorGreen.upperBound = newUpperBound;
                });
              },
              onChangedThresholdBlue: (double newUpperBound) {
                logger.t("_MyHomePageState - onChangedThresholdBlue");
                setState(() {
                  thresholdColorBlue.upperBound = newUpperBound;
                });
              },
            ),
            BoundLevelColorSliders(
              mode: BoundLevelColorSlidersMode.lowerBound,
              red: thresholdColorRed,
              green: thresholdColorGreen,
              blue: thresholdColorBlue,
              onChangedThresholdRed: (double newLowerBound) {
                logger.t("_MyHomePageState - onChangedThresholdRed - lower");
                setState(() {
                  thresholdColorRed.lowerBound = newLowerBound;
                });
              },
              onChangedThresholdGreen: (double newLowerBound) {
                setState(() {
                  thresholdColorGreen.lowerBound = newLowerBound;
                });
              },
              onChangedThresholdBlue: (double newLowerBound) {
                setState(() {
                  thresholdColorBlue.lowerBound = newLowerBound;
                });
              },
            ),
            // Editor
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: 'Enter text here...',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) => _parseTextToList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: colors.length,
                      itemBuilder: (ctx, idx) {
                        String cHex =
                            colors[idx][0] == "#"
                                ? colors[idx].substring(1)
                                : colors[idx];

                        Color inputColor = ColorFactory.fromHex(cHex);
                        String closestHex;
                        try {
                          closestHex =
                              inputColor
                                  .findClosest(
                                    TerminalColors.list,
                                    redLowerThreshold:
                                        (thresholdColorRed.lowerBound) / 255,
                                    greenLowerThreshold:
                                        (thresholdColorGreen.lowerBound) / 255,
                                    blueLowerThreshold:
                                        (thresholdColorBlue.lowerBound) / 255,
                                    redUpThreshold:
                                        (thresholdColorRed.upperBound) / 255,
                                    greenUpThreshold:
                                        (thresholdColorGreen.upperBound) / 255,
                                    blueUpThreshold:
                                        (thresholdColorBlue.upperBound) / 255,
                                  )
                                  .toHexString();
                        } catch (e) {
                          closestHex = "No Match";
                        }
                        return ListTile(
                          title: Row(
                            children: [
                              ColorPreview(
                                hexColor: cHex,
                                shape: BoxShape.rectangle,
                                size: 16,
                              ),
                              Text("$cHex = $closestHex"),
                              ColorPreview(
                                hexColor: closestHex,
                                shape: BoxShape.rectangle,
                                size: 16,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO loop over the main array and compose a proper string to be copied
          Clipboard.setData(ClipboardData(text: _textController.text));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.copy_all_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
