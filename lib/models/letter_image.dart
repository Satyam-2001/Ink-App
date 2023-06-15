import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class LetterImage {
  LetterImage({
    String? id,
    required this.letter,
    required this.file,
    int? baseline,
    double? sizeScale,
  })  : baseline = baseline ?? 0,
        id = id ?? uuid.v4(),
        sizeScale = sizeScale ?? 1.0;

  final String letter;
  File file;
  final int baseline;
  final String id;
  final double sizeScale;

  void replaceFile(File newFile) {
    file.delete();
    file = newFile;
  }
}
