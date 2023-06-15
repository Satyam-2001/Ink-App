import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/letter_image.dart';
import 'package:ink/providers/letters.dart';
import 'package:ink/utility/circular_container.dart';
import 'package:ink/utility/crop_image.dart';
import 'package:ink/utility/slider_input.dart';
import 'package:ink/utility/text_box_referenced_line.dart';

class LetterEditScreen extends ConsumerStatefulWidget {
  const LetterEditScreen({super.key, required this.letterImageObject});

  final LetterImage letterImageObject;

  @override
  ConsumerState<LetterEditScreen> createState() => _LetterEditScreenState();
}

class _LetterEditScreenState extends ConsumerState<LetterEditScreen> {
  late TextEditingController _textController;
  late File file;
  late int baseline;
  late double sizeScale;

  void getFileSIze(File file) async {
    // final image = Image.file(file);
    // Completer<Image> completer = new Completer<Image>();
    // image.image
    //   .resolve(new ImageConfiguration())
    //   .addListener(ImageStreamListener((ImageInfo info, bool _) {
    //     completer.complete(info.image));
    //   });
    var decodedImage = await decodeImageFromList(file.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);
  }

  @override
  void initState() {
    file = widget.letterImageObject.file;
    _textController =
        TextEditingController(text: widget.letterImageObject.letter);
    baseline = widget.letterImageObject.baseline;
    sizeScale = widget.letterImageObject.sizeScale * 100;
    // getFileSIze(widget.letterImageObject.file);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black54,
        title: const Text('Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _lineReferencedLetterBox,
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularContainer(
                  width: 120.0,
                  radius: 20,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: const EdgeInsets.only(right: 64),
                  color: Theme.of(context).colorScheme.primary.withAlpha(60),
                  child: const Text('Character'),
                ),
                Expanded(
                  child: Center(
                    child: CircularContainer(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      radius: 10,
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(20),
                      height: 40,
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 16, bottom: 8),
                            border: InputBorder.none,
                            counterText: ''
                            // border: OutlineInputBorder(gapPadding: 2),
                            ),
                        maxLines: 1,
                        maxLength: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomSliderInput(
              title: 'Base Line',
              value: max(baseline.toDouble(), -50.0),
              min: -50.0,
              max: 50.0,
              setValue: (val) {
                setState(() {
                  baseline = val.toInt();
                });
              },
            ),
            CustomSliderInput(
              title: 'Size Scale',
              value: sizeScale,
              min: 10.0,
              max: 500.0,
              setValue: (val) {
                setState(() {
                  sizeScale = val;
                });
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _saveLetter,
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _saveLetter() {
    ref.read(lettersProvider.notifier).update(
          id: widget.letterImageObject.id,
          letter: _textController.text,
          file: file,
          baseline: baseline,
          sizeScale: sizeScale / 100,
        );
    Navigator.pop(context);
  }

  Widget get _lineReferencedLetterBox {
    return TextBoxReferencedLine(
      child: Positioned(
        left: 0,
        right: 0,
        bottom: 40 + baseline.toDouble(),
        child: Center(
          child: Image.file(
            file,
            // scale: sizeScale / 100,
            // width: (28 * sizeScale) / 100,
            // cacheWidth: (28 * sizeScale) ~/ 100,
          ),
        ),
      ),
      onTap: () async {
        final result = await Navigator.of(context).push<Map<String, dynamic>>(
          MaterialPageRoute(
            builder: (ctx) => CropImageScreen(
              title: 'Crop',
              file: widget.letterImageObject.file,
            ),
          ),
        );
        if (result == null) {
          return;
        }
        if (result['image'] != null) {
          setState(() {
            file = result['image'];
          });
        }
      },
    );
  }
}
