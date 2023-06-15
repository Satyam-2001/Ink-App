import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/providers/mode.dart';
import 'package:photo_view/photo_view.dart';

class PageImageScreen extends ConsumerStatefulWidget {
  const PageImageScreen({
    super.key,
    required this.imageFile,
    required this.deleteImage,
  });

  final File imageFile;
  final void Function() deleteImage;

  @override
  ConsumerState<PageImageScreen> createState() => _PageImageScreenState();
}

class _PageImageScreenState extends ConsumerState<PageImageScreen> {
  bool showAppbar = true;

  void _toggleAppBar() {
    setState(() {
      showAppbar = !showAppbar;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(modeProvider);
    bool isDarkMode = mode == 'Dark';

    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: showAppbar ? 1 : 0,
        backgroundColor: !showAppbar
            ? Colors.transparent
            : isDarkMode
                ? Colors.black54
                : Colors.white54,
        actions: [
          IconButton(
            onPressed: () {
              widget.deleteImage();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: _toggleAppBar,
          child: Center(
            child: Hero(
              tag: widget.imageFile.path,
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                imageProvider: FileImage(widget.imageFile),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
