import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ink/utility/circular_container.dart';

class CustomColorPickerInput extends StatefulWidget {
  const CustomColorPickerInput({
    super.key,
    required this.color,
    required this.setColor,
  });

  final Color color;
  final void Function(Color color) setColor;

  @override
  State<CustomColorPickerInput> createState() => _CustomColorPickerInputState();
}

class _CustomColorPickerInputState extends State<CustomColorPickerInput> {
  late Color pickedColor;

  @override
  void initState() {
    pickedColor = widget.color;
    super.initState();
  }

  void colorPickerDialog() {
    showDialog<Color>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickedColor,
            onColorChanged: (value) => setState(() {
              pickedColor = value;
            }),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              widget.setColor(pickedColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: colorPickerDialog,
      child: CircularContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        color: widget.color.withAlpha(80),
        radius: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Default Ink Color',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
