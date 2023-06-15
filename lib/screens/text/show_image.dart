import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ink/screens/text/extract_text.dart';
import 'package:ink/screens/text/look_image.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowImageScreen extends ConsumerStatefulWidget {
  const ShowImageScreen({
    super.key,
    required this.imageFile,
  });

  final File imageFile;

  @override
  ConsumerState<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends ConsumerState<ShowImageScreen> {
  void _extraxtTextFromImage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => ExtractTextScreen(imageFile: widget.imageFile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LookImageScreen(
      file: widget.imageFile,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.onBackground.withAlpha(30),
      ),
      bottomBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text('Cancel'),
          ),
          TextButton.icon(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            icon: const Icon(Icons.build),
            onPressed: () => _extraxtTextFromImage(),
            label: const Text("Extract Letter"),
          )
        ],
      ),
    );
  }
}
