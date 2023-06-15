import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/letter_image.dart';
import 'package:ink/providers/letters.dart';
import 'package:ink/utility/alert_dialog.dart';
import 'package:ink/utility/crop_image.dart';
import 'package:ink/widgets/page/popover_menu.dart';
import 'package:ink/widgets/text/letter_image_block.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ink/connection/connection.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ExtractTextScreen extends ConsumerStatefulWidget {
  const ExtractTextScreen({super.key, required this.imageFile});

  final File imageFile;

  @override
  ConsumerState<ExtractTextScreen> createState() => _ExtractTextScreenState();
}

class _ExtractTextScreenState extends ConsumerState<ExtractTextScreen> {
  List<LetterImage> _loadedLetterImageArray = [];
  final List<LetterImage> _selectedLetterImageArray = [];

  late Future<void> _imageFuture;

  void toggleLetterImageFromArray(LetterImage letterObj) {
    if (_selectedLetterImageArray.contains(letterObj)) {
      setState(() {
        _selectedLetterImageArray.remove(letterObj);
      });
    } else {
      setState(() {
        _selectedLetterImageArray.add(letterObj);
      });
    }
  }

  void _imageOnTap(LetterImage letterObj) {
    if (_selectedLetterImageArray.isNotEmpty) {
      toggleLetterImageFromArray(letterObj);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => CropImageScreen(title: 'Crop', file: letterObj.file)
          // LookImageScreen(
          //   file: file,
          //   backgroundColor: Colors.white12,
          //   appBar: AppBar(
          //     backgroundColor:
          //         Theme.of(context).colorScheme.background.withAlpha(40),
          //   ),
          // ),
          ),
    );
  }

  void _imageOnLongPress(LetterImage letterObj) {
    toggleLetterImageFromArray(letterObj);
  }

  Future<void> _sendRequest() async {
    const uri = '$API_URL/letter/image';
    final bytes = widget.imageFile.readAsBytesSync();

    var request = http.MultipartRequest('POST', Uri.parse(uri));
    final httpImage = http.MultipartFile.fromBytes('upload', bytes,
        contentType: MediaType.parse('image/jpeg'), filename: 'myImage.jpeg');
    request.files.add(httpImage);
    final streamedResponse = await request.send();
    final response = await streamedResponse.stream.bytesToString();
    final parsedJson = await jsonDecode(response);
    final tempDir = await getTemporaryDirectory();

    List<LetterImage> tempArray = [];
    for (var buffer in parsedJson) {
      List<dynamic> bufferDynamic = buffer['image']['data'];
      final List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
      final bufferList = Uint8List.fromList(bufferInt);
      File file = await File(
              '${tempDir.path}/ink-frombuffer-${DateTime.now().millisecondsSinceEpoch}.png')
          .create();
      file.writeAsBytesSync(bufferList);
      final newLetterImage = LetterImage(
          letter: buffer['text'], file: file, baseline: buffer['baseline']);
      tempArray.add(newLetterImage);
    }
    tempArray.sort((a, b) => a.letter.compareTo(b.letter));
    setState(() {
      _loadedLetterImageArray = tempArray;
    });
  }

  void _deleteDialogHandler() {
    showAlertDialog(
      context: context,
      content: 'Do you want to delete the selected letters?',
      action: () {
        setState(() {
          _loadedLetterImageArray.removeWhere(
              (letter) => _selectedLetterImageArray.contains(letter));
          _selectedLetterImageArray.removeRange(
              0, _selectedLetterImageArray.length);
        });
      },
    );
  }

  @override
  void initState() {
    _imageFuture = _sendRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelectedExist = _selectedLetterImageArray.isNotEmpty;
    int selectedLettersCount = _selectedLetterImageArray.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectedExist
            ? '$selectedLettersCount Selected'
            : 'Extracted Letters'),
        actions: [
          isSelectedExist
              ? IconButton(
                  onPressed: _deleteDialogHandler,
                  icon: const Icon(Icons.delete),
                )
              : _buildPopOver,
        ],
      ),
      persistentFooterButtons: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        TextButton(
          onPressed: _saveAllLettersImage,
          child: const Text('Save All'),
        )
      ],
      body: FutureBuilder(
          future: _imageFuture,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_loadedLetterImageArray.isEmpty) {
              return Center(
                child: Text(
                  'Oops! Nothing Found',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withAlpha(180),
                  ),
                ),
              );
            }
            return GridView(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              children: [
                for (var obj in _loadedLetterImageArray) _letterImageBlock(obj)
              ],
            );
          }),
    );
  }

  void _saveAllLettersImage() async {
    await ref
        .read(lettersProvider.notifier)
        .addLettersImageList(_loadedLetterImageArray);
    Navigator.pop(context);
  }

  Widget get _buildPopOver {
    return PopOverMenu(
      children: [
        PopOverMenuItem(
            onPressed: () {
              setState(() {
                _selectedLetterImageArray.removeRange(
                    0, _selectedLetterImageArray.length);
                _selectedLetterImageArray.addAll(_loadedLetterImageArray);
              });
            },
            icon: Icons.playlist_add_check_rounded,
            title: 'Select All')
      ],
    );
  }

  Widget _letterImageBlock(LetterImage imageObj) {
    return LettersImageBlock(
      onTap: () => _imageOnTap(imageObj),
      onLongPress: () => _imageOnLongPress(imageObj),
      isSelected: _selectedLetterImageArray.contains(imageObj),
      letterImage: imageObj,
    );
  }
}
