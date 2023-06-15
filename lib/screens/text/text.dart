import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ink/screens/text/show_image.dart';
import 'package:ink/widgets/text/letters_list.dart';
import 'package:ink/widgets/main_drawer.dart';

import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ink/widgets/text/search/search_bottom_sheet.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key, required this.setScreen});

  final void Function(String identifier) setScreen;

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  void _openSearchOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (ctx) => const SearchBottomSheet(),
    );
  }

  void _chooseImage(source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) {
      return;
    }

    File imageFile = File(image.path);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ShowImageScreen(imageFile: imageFile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black54,
        actions: [
          IconButton(
            onPressed: _openSearchOverlay,
            icon: const Icon(Icons.search),
          )
        ],
        title: const Text('Text'),
      ),
      drawer: MainDrawer(setScreen: widget.setScreen),
      body: const LettersList(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        child: const Icon(Icons.add),
        children: [
          FloatingActionButton(
            shape: const CircleBorder(),
            heroTag: null,
            child: const Icon(Icons.camera_alt),
            onPressed: () => _chooseImage(ImageSource.camera),
          ),
          FloatingActionButton(
            shape: const CircleBorder(),
            heroTag: null,
            child: const Icon(Icons.image),
            onPressed: () => _chooseImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}
