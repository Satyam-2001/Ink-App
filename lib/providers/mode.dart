import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/database/nosql_database.dart';
import 'package:sembast/sembast.dart';

class ModeNotifier extends StateNotifier<String> {
  ModeNotifier() : super('Light') {
    store = StoreRef.main();
    getMode();
  }

  late StoreRef<Object?, Object?> store;

  Future<void> getMode() async {
    try {
      Database db = await settingsDatabase.getDtabase();
      state = await store.record('mode').get(db) as String;
    } catch (e) {}
  }

  void setMode(String mode) async {
    state = mode;
    Database db = await settingsDatabase.getDtabase();
    store.record('mode').put(db, mode);
  }
}

final modeProvider = StateNotifierProvider<ModeNotifier, String>(
  (ref) => ModeNotifier(),
);
