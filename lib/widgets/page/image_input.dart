import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ink/utility/crop_image.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onSelectImage,
    required this.isDeleteHandlerOpen,
    required this.setDeleteHandlerState,
    this.selectedImage,
  });

  final void Function(File? selectedImage) onSelectImage;
  final File? selectedImage;
  final bool isDeleteHandlerOpen;
  final void Function(bool value) setDeleteHandlerState;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  void _longPressImage() {
    widget.setDeleteHandlerState(true);
  }

  void _openImagePickOptionOverlay() {
    showModalBottomSheet(
      context: context,
      constraints:
          const BoxConstraints(minWidth: double.infinity, maxHeight: 180),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              'Pick Photo',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: () => _chooseImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera')),
                ElevatedButton.icon(
                    onPressed: () => _chooseImage(ImageSource.gallery),
                    icon: const Icon(Icons.image),
                    label: const Text('Gallery')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _chooseImage(source) async {
    if (widget.isDeleteHandlerOpen) {
      widget.setDeleteHandlerState(false);
      return;
    }
    Navigator.pop(context);
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) {
      return;
    }

    widget.onSelectImage(File(image.path));
  }

  void _imageEditorScreenOpen() async {
    if (widget.isDeleteHandlerOpen) {
      widget.setDeleteHandlerState(false);
      return;
    }
    final cropData = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
          builder: (context) => CropImageScreen(
                title: 'Crop',
                file: widget.selectedImage!,
              )
          // deleteImage: () => widget.onSelectImage(null)),
          ),
    );

    if (cropData == null) {
      return;
    }

    if (cropData['image'] != null) {
      print(cropData);
      widget.onSelectImage(cropData['image']);
    } else if (cropData['delete']) {
      widget.onSelectImage(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _openImagePickOptionOverlay,
      icon: const Icon(Icons.camera_alt),
      label: const Text('Take Photo'),
    );

    if (widget.selectedImage != null) {
      content = GestureDetector(
        onTap: _imageEditorScreenOpen,
        child: Hero(
          tag: widget.selectedImage!.path,
          child: Image.file(
            widget.selectedImage!,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (widget.selectedImage == null) {
          return _openImagePickOptionOverlay();
        }
        widget.setDeleteHandlerState(false);
      },
      onLongPress: widget.selectedImage == null ? null : _longPressImage,
      child: Card(
        elevation: 8,
        child: Container(
          // padding: const EdgeInsets.symmetric(vertical: 8),
          height: 350,
          // constraints: BoxConstraints.loose(const Size(double.infinity, 300)),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            border: Border.all(
              width: 1,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
            ),
            gradient: widget.selectedImage != null ? null : null,
          ),
          foregroundDecoration: BoxDecoration(
            color: widget.isDeleteHandlerOpen
                ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                : null,
          ),
          alignment: Alignment.center,
          child: content,
        ),
      ),
    );
  }
}
