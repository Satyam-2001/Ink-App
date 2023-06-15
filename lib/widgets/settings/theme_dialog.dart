import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/providers/mode.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox(
      {super.key,
      required this.value,
      required this.title,
      required this.onChange});

  final String value;
  final String title;
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;
    final isChecked = value == title;

    return ListTile(
      onTap: () {
        if (isChecked) {
          return;
        }
        onChange(title);
      },
      leading: Icon(
        isChecked ? Icons.circle : Icons.circle_outlined,
        color: color,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: color,
        ),
      ),
    );
  }
}

class ThemeDialog extends ConsumerStatefulWidget {
  const ThemeDialog({super.key});

  @override
  ConsumerState<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends ConsumerState<ThemeDialog> {
  late String mode;

  @override
  void initState() {
    mode = ref.read(modeProvider);
    super.initState();
  }

  void onChangeModeHandler(String newMode) {
    setState(() {
      mode = newMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckBox(
            value: mode,
            title: 'Light',
            onChange: onChangeModeHandler,
          ),
          CustomCheckBox(
            value: mode,
            title: 'Dark',
            onChange: onChangeModeHandler,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              ref.read(modeProvider.notifier).setMode(mode);
              Navigator.pop(context);
            },
            child: const Text('Save')),
      ],
    );
  }
}
