import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hextty/color_extensions.dart';
import 'package:hextty/color_preview.dart';
import 'package:hextty/themes.dart';

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
      // themeMode: ThemeMode.dark,
      //theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //),
      theme: NeoBrutalistTheme.darkTheme,
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
  List<String> colors = [];

  double _redValueThreshold = 178;
  double _greenValueThreshold = 178;
  double _blueValueThreshold = 178;

  double _redUpperBoundThreshold = 125;
  double _greenUpperBoundThreshold = 125;
  double _blueUpperBoundThreshold = 125;

  final TextEditingController _textController = TextEditingController();
  void _parseTextToList() {
    // Split the text into lines, removing any empty lines
    setState(() {
      colors =
          _textController.text
              .split('\n')
              .where((line) => line.trim().isNotEmpty)
              // .map((line) => ColorEntry(line.trim()))
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Lower Bound Threshold"),
            Row(
              // Equivalent to CSS justify-content: space-around
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // Equivalent to CSS align-items: center
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.red,
                    inactiveTrackColor: Colors.red.withValues(alpha: 0.3),
                    thumbColor: Colors.red,
                  ),
                  child: Slider(
                    value: _redValueThreshold,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _redValueThreshold.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _redValueThreshold = value;
                      });
                    },
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.green,
                    inactiveTrackColor: Colors.green.withValues(alpha: 0.3),
                    thumbColor: Colors.green,
                  ),
                  child: Slider(
                    value: _greenValueThreshold,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _greenValueThreshold.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _greenValueThreshold = value;
                      });
                    },
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.blue.withValues(alpha: 0.3),
                    thumbColor: Colors.blue,
                  ),
                  child: Slider(
                    value: _blueValueThreshold,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _blueValueThreshold.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _blueValueThreshold = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Text("Upper Bound Threshold"),
            Row(
              // Equivalent to CSS justify-content: space-around
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // Equivalent to CSS align-items: center
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.red,
                    inactiveTrackColor: Colors.red.withValues(alpha: 0.3),
                    thumbColor: Colors.red,
                  ),
                  child: Slider(
                    value: _redUpperBoundThreshold,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _redUpperBoundThreshold.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _redUpperBoundThreshold = value;
                      });
                    },
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.green,
                    inactiveTrackColor: Colors.green.withValues(alpha: 0.3),
                    thumbColor: Colors.green,
                  ),
                  child: Slider(
                    value: _greenUpperBoundThreshold,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _greenUpperBoundThreshold.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _greenUpperBoundThreshold = value;
                      });
                    },
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.blue.withValues(alpha: 0.3),
                    thumbColor: Colors.blue,
                  ),
                  child: Slider(
                    value: _blueUpperBoundThreshold,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _blueUpperBoundThreshold.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _blueUpperBoundThreshold = value;
                      });
                    },
                  ),
                ),
              ],
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
                                        (_redValueThreshold) / 255,
                                    greenLowerThreshold:
                                        (_greenValueThreshold) / 255,
                                    blueLowerThreshold:
                                        (_blueValueThreshold) / 255,
                                    redUpThreshold:
                                        (_redUpperBoundThreshold) / 255,
                                    greenUpThreshold:
                                        (_greenUpperBoundThreshold) / 255,
                                    blueUpThreshold:
                                        (_blueUpperBoundThreshold) / 255,
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
          Clipboard.setData(ClipboardData(text: _textController.text));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.copy_all_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
