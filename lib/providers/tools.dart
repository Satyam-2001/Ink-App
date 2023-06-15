import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/database/nosql_database.dart';
import 'package:sembast/sembast.dart';

final Map<String, dynamic> kInitialTools = {
  'color': [255, 20, 100, 223],
  'fontSize': 40.0,
  'fontWeight': 300.0,
  'letterSpacing': 0.0,
  'spaceWidth': 10.0,
};

class ToolsNotifier extends StateNotifier<Map<String, dynamic>> {
  ToolsNotifier() : super(kInitialTools) {
    store = StoreRef.main();
    getStoredData();
  }

  late StoreRef<Object?, Object?> store;

  Future<void> getStoredData() async {
    try {
      Database db = await toolsDatabase.getDtabase();
      final color = await store.record('color').get(db) as List<int>;
      final fontSize = await store.record('fontSize').get(db) as double;
      final fontWeight = await store.record('fontWeight').get(db) as double;
      final letterSpacing =
          await store.record('letterSpacing').get(db) as double;
      final spaceWidth = await store.record('spaceWidth').get(db) as double;
      state = {
        'color': color,
        'fontSize': fontSize,
        'fontWeight': fontWeight,
        'letterSpacing': letterSpacing,
        'spaceWidth': spaceWidth,
      };
    } catch (e) {}
  }

  void setAll(Map<String, dynamic> toolsSetting) async {
    state = toolsSetting;
    Database db = await toolsDatabase.getDtabase();
    store.records(toolsSetting.keys).put(db, toolsSetting.values.toList());
  }

  void set(String key, dynamic value) async {
    state = {...state, key: value};
    Database db = await toolsDatabase.getDtabase();
    store.record(key).put(db, value);
  }
}

final toolsProvider =
    StateNotifierProvider<ToolsNotifier, Map<String, dynamic>>(
  (ref) => ToolsNotifier(),
);
