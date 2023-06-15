import 'package:flutter/material.dart';
import 'package:ink/widgets/main_drawer.dart';
import 'package:ink/widgets/tools/color_picker.dart';
import 'package:ink/utility/slider_input.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key, required this.setScreen});

  final void Function(String identifier) setScreen;

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  Color defaultInkColor = Colors.blue.shade900;
  double fontSize = 40;
  double fontWeight = 300;
  double letterSpacing = 0;
  double spaceWidth = 10;

  void setInitialValue() {
    setState(() {
      defaultInkColor = Colors.blue.shade900;
      fontSize = 40;
      fontWeight = 300;
      letterSpacing = 0;
      spaceWidth = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black54,
        title: const Text('Tools'),
      ),
      drawer: MainDrawer(setScreen: widget.setScreen),
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            child: Card(
              color: const Color.fromARGB(255, 250, 250, 250),
              elevation: 2,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ink',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.values[fontWeight.round() ~/ 100],
                        fontSize: fontSize,
                        letterSpacing: letterSpacing,
                        color: defaultInkColor,
                      ),
                    ),
                    SizedBox(width: spaceWidth),
                    Text(
                      'App',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.values[fontWeight.round() ~/ 100],
                        fontSize: fontSize,
                        letterSpacing: letterSpacing,
                        color: defaultInkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // constraints: const BoxConstraints.expand(),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CustomColorPickerInput(
                        color: defaultInkColor,
                        setColor: (value) {
                          setState(() {
                            defaultInkColor = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomSliderInput(
                        title: 'Font Size',
                        value: fontSize,
                        min: 10,
                        max: 60,
                        color: defaultInkColor,
                        setValue: (value) {
                          setState(() {
                            fontSize = value;
                          });
                        },
                      ),
                      CustomSliderInput(
                        title: 'Font Weight',
                        min: 100,
                        max: 800,
                        divisions: 7,
                        value: fontWeight,
                        color: defaultInkColor,
                        setValue: (value) {
                          setState(() {
                            fontWeight = value;
                          });
                        },
                      ),
                      CustomSliderInput(
                        title: 'Letter Spacing',
                        min: 0,
                        max: 20,
                        value: letterSpacing,
                        color: defaultInkColor,
                        setValue: (value) {
                          setState(() {
                            letterSpacing = value;
                          });
                        },
                      ),
                      CustomSliderInput(
                        title: 'Space Width',
                        min: 0,
                        max: 30,
                        value: spaceWidth,
                        color: defaultInkColor,
                        setValue: (value) {
                          setState(() {
                            spaceWidth = value;
                          });
                        },
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: setInitialValue,
                            child: const Text('Discard Changes'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
