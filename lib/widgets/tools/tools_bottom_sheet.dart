import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/providers/tools.dart';
import 'package:ink/utility/text_box_referenced_line.dart';
import 'package:ink/widgets/tools/color_picker.dart';
import 'package:ink/utility/slider_input.dart';

class ToolsBottomSheet extends ConsumerStatefulWidget {
  const ToolsBottomSheet({super.key});

  @override
  ConsumerState<ToolsBottomSheet> createState() => _ToolsBottomSheetState();
}

class _ToolsBottomSheetState extends ConsumerState<ToolsBottomSheet> {
  Color defaultInkColor = Colors.blue.shade900;
  double fontSize = 40;
  double fontWeight = 300;
  double letterSpacing = 0;
  double spaceWidth = 10;

  void setInitialValue() {
    Map<String, dynamic> toolsValue = ref.read(toolsProvider);
    final colorArray = toolsValue['color'];
    setState(() {
      defaultInkColor = Color.fromARGB(
          colorArray[0], colorArray[1], colorArray[2], colorArray[3]);
      fontSize = toolsValue['fontSize'];
      fontWeight = toolsValue['fontWeight'];
      letterSpacing = toolsValue['letterSpacing'];
      spaceWidth = toolsValue['spaceWidth'];
    });
  }

  @override
  void initState() {
    setInitialValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          _buildInkAppTextBox,
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
                        setValue: (value) {
                          setState(() {
                            spaceWidth = value;
                          });
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _actionButtonsGroup,
        ],
      ),
    );
  }

  Widget get _buildInkAppTextBox {
    return TextBoxReferencedLine(
      child: Positioned(
        left: 0,
        right: 0,
        bottom: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getCustomText('Ink'),
            SizedBox(width: spaceWidth),
            _getCustomText('App'),
          ],
        ),
      ),
    );
  }

  Widget _getCustomText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.values[fontWeight.round() ~/ 100],
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        color: defaultInkColor,
      ),
    );
  }

  Widget get _actionButtonsGroup {
    return Card(
      elevation: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: setInitialValue,
            child: const Text('Discard Changes'),
          ),
          ElevatedButton(
            onPressed: _saveToolsValues,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveToolsValues() {
    ref.read(toolsProvider.notifier).setAll({
      'color': [
        defaultInkColor.alpha,
        defaultInkColor.red,
        defaultInkColor.green,
        defaultInkColor.blue
      ],
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'letterSpacing': letterSpacing,
      'spaceWidth': spaceWidth,
    });
    Navigator.pop(context);
  }
}
