import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LookImageScreen extends ConsumerStatefulWidget {
  const LookImageScreen({
    super.key,
    required this.file,
    this.appBar,
    this.bottomBar,
    this.backgroundColor,
  });

  final File file;
  final Widget? bottomBar;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  @override
  ConsumerState<LookImageScreen> createState() => _LookImageScreenState();
}

class _LookImageScreenState extends ConsumerState<LookImageScreen> {
  bool showAppbar = true;

  void _toggleAppBar() {
    setState(() {
      showAppbar = !showAppbar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: widget.backgroundColor,
      appBar: showAppbar ? widget.appBar : null,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: _toggleAppBar,
              child: Center(
                child: PhotoView(
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  imageProvider: FileImage(widget.file),
                ),
              ),
            ),
          ),
          if (showAppbar && widget.bottomBar != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Theme.of(context).colorScheme.onBackground.withAlpha(40),
                width: double.infinity,
                height: 70,
                child: widget.bottomBar,
              ),
            ),
        ],
      ),
    );
  }
}
