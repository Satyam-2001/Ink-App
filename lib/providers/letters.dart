import 'dart:io';

import 'package:ink/database/save_file.dart';
import 'package:ink/database/sql_database.dart';
import 'package:ink/models/letter_image.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final _database = SQLDatabase();

class LettersNotifier extends StateNotifier<List<LetterImage>> {
  LettersNotifier() : super([]);

  LetterImage _formatLetter(Map<String, Object?> data) {
    return LetterImage(
      id: data['id'] as String,
      letter: data['letter'] as String,
      file: File(data['file'] as String),
      baseline: (data['baseline'] as num).toInt(),
      sizeScale: (data['sizeScale'] as num).toDouble(),
    );
  }

  List<LetterImage> _formatLeters(List<Map<String, Object?>> data) {
    final List<LetterImage> letters = [];
    for (var row in data) {
      try {
        final LetterImage page = _formatLetter(row);
        letters.add(page);
      } catch (e) {}
    }
    return letters;
  }

  Future<void> loadLetters() async {
    final db = await _database.getDatabase();
    try {
      final data = await db.query(tableLetterName);
      state = _formatLeters(data);
    } catch (e) {}
  }

  Future<void> _addLetter(LetterImage letterImage) async {
    final copiedImage = await saveFile(letterImage.file);
    letterImage.replaceFile(copiedImage);

    final db = await _database.getDatabase();
    await db.insert(
      tableLetterName,
      {
        'id': letterImage.id,
        'file': letterImage.file.path,
        'letter': letterImage.letter,
        'baseline': letterImage.baseline,
        'sizeScale': letterImage.sizeScale,
      },
    );
  }

  Future<void> removeById(String id) async {
    final db = await _database.getDatabase();
    await db.delete(
      tableLetterName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> removeAll(List<LetterImage> lettersImageList) async {
    final dummyList = [...state];
    dummyList.removeWhere((obj) => lettersImageList.contains(obj));
    state = dummyList;
    for (var obj in lettersImageList) {
      obj.file.delete();
      await removeById(obj.id);
    }
  }

  Future<void> addLettersImageList(List<LetterImage> lettersImageList) async {
    state = [...state, ...lettersImageList];
    for (LetterImage obj in lettersImageList) {
      _addLetter(obj);
    }
  }

  Future<void> addLetterImage(LetterImage letteImage) async {
    state = [...state, letteImage];
    await _addLetter(letteImage);
  }

  Future<void> update({
    required String id,
    required File file,
    required String letter,
    required int baseline,
    required double sizeScale,
  }) async {
    final index = state.indexWhere((element) => element.id == id);
    if (index == -1) {
      return;
    }

    final db = await _database.getDatabase();
    final data = await db.query(
      tableLetterName,
      where: "id = ?",
      whereArgs: [id],
    );

    final tempLetterImage = _formatLetter(data[0]);

    if (tempLetterImage.file.path != file.path) {
      tempLetterImage.file.delete();
      final copiedfile = await saveFile(file);
      file = copiedfile;
    }

    final letterImage = LetterImage(
      id: id,
      letter: letter,
      file: file,
      sizeScale: sizeScale,
      baseline: baseline,
    );

    await db.update(
      tableLetterName,
      {
        'id': id,
        'file': file.path,
        'letter': letterImage.letter,
        'baseline': letterImage.baseline,
        'sizeScale': letterImage.sizeScale,
      },
      where: "id = ?",
      whereArgs: [id],
    );

    final dummyList = [...state];
    dummyList[index] = letterImage;
    state = dummyList;
  }
}

final lettersProvider =
    StateNotifierProvider<LettersNotifier, List<LetterImage>>(
  (ref) => LettersNotifier(),
);
