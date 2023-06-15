import 'dart:io';

import 'package:ink/database/save_file.dart';
import 'package:ink/database/sql_database.dart';
import 'package:ink/models/page_info.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/providers/page_screen_settings.dart';

final _database = SQLDatabase();

class PageInfoListNotifier extends StateNotifier<List<PageInfo>> {
  PageInfoListNotifier() : super(<PageInfo>[]);

  PageInfo formatPage(Map<String, Object?> data) {
    return PageInfo(
      id: data['id'] as String,
      image: File(data['image'] as String),
      xpos: (data['xpos'] as num).toInt(),
      ypos: (data['ypos'] as num).toInt(),
      lineHeight: (data['lineheight'] as num).toInt(),
    );
  }

  List<PageInfo> formatPages(List<Map<String, Object?>> data) {
    final List<PageInfo> pages = [];
    for (var row in data) {
      try {
        final PageInfo page = formatPage(row);
        pages.add(page);
      } catch (e) {}
    }
    return pages;
  }

  Future<void> loadPages() async {
    final db = await _database.getDatabase();
    try {
      final data = await db.query(tablePageName);
      state = formatPages(data);
    } catch (e) {}
  }

  void updatePage({
    required String id,
    required File image,
    required int xpos,
    required int ypos,
    required int lineHeight,
  }) async {
    try {
      final index = state.indexWhere((page) => page.id == id);
      if (index == -1) {
        return;
      }

      final db = await _database.getDatabase();
      final data = await db.query(
        tablePageName,
        where: "id = ?",
        whereArgs: [id],
      );

      final pageInfo = formatPage(data[0]);

      if (pageInfo.image.path != image.path) {
        final oldImage = File(pageInfo.image.path);
        oldImage.delete();
        image = await saveFile(image);
      }

      final newPageInfo = PageInfo(
        image: image,
        xpos: xpos,
        ypos: ypos,
        lineHeight: lineHeight,
      );

      final dummyState = [...state];
      dummyState[index] = newPageInfo;
      state = dummyState;

      db.update(
        tablePageName,
        {
          'id': id,
          'image': image.path,
          'xpos': xpos,
          'ypos': ypos,
          'lineheight': lineHeight,
        },
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {}
  }

  void toggleOrientation() {
    final dummyState = [...state];
    state = dummyState.reversed.toList();
  }

  void addPage({
    required File image,
    required int xpos,
    required int ypos,
    required int lineHeight,
  }) async {
    final copiedImage = await saveFile(image);

    final newPageInfo = PageInfo(
      image: copiedImage,
      xpos: xpos,
      ypos: ypos,
      lineHeight: lineHeight,
    );

    final db = await _database.getDatabase();
    db.insert(
      tablePageName,
      {
        'id': newPageInfo.id,
        'image': newPageInfo.image.path,
        'xpos': newPageInfo.xpos,
        'ypos': newPageInfo.ypos,
        'lineheight': newPageInfo.lineHeight,
      },
    );
    state = [newPageInfo, ...state];
  }

  void removePageById(String id) async {
    final db = await _database.getDatabase();
    db.delete(
      tablePageName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  void removePage(PageInfo selectedPageInfo) async {
    selectedPageInfo.image.delete();
    state = state.where((page) => page != selectedPageInfo).toList();
    removePageById(selectedPageInfo.id);
  }

  void removeSelectedPages(List<PageInfo> selectedPagesInfo) async {
    state = state.where((page) => !selectedPagesInfo.contains(page)).toList();
    for (PageInfo page in selectedPagesInfo) {
      page.image.delete();
      removePageById(page.id);
    }
  }
}

final pageInfoListProvider =
    StateNotifierProvider<PageInfoListNotifier, List<PageInfo>>(
  (ref) => PageInfoListNotifier(),
);

final filteredPageInfoListProvider = Provider((ref) {
  final List<PageInfo> pageList = ref.watch(pageInfoListProvider);
  final bool isNewToOld = ref.watch(pageScreenSettingsProvider);
  if (isNewToOld) {
    return pageList;
  }
  return pageList.reversed.toList();
});
