import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/database/nosql_database.dart';
import 'package:sembast/sembast.dart';

class PageScreenSettingsNotifier extends StateNotifier<bool> {
  PageScreenSettingsNotifier() : super(true) {
    store = StoreRef.main();
    getSortBy();
  }

  late StoreRef<Object?, Object?> store;
  // final WidgetRef pageListRef;

  Future<void> getSortBy() async {
    try {
      settingsDatabase.db ??= await settingsDatabase.getDtabase();
      bool newState =
          await store.record('pageSortBy').get(settingsDatabase.db!) as bool;
      state = newState;
    } catch (e) {}
  }

  void setSortBy(bool mode) async {
    state = mode;
    settingsDatabase.db ??= await settingsDatabase.getDtabase();
    store.record('pageSortBy').put(settingsDatabase.db!, mode);
  }

  void toggleSortBy() {
    setSortBy(!state);
  }
}

final pageScreenSettingsProvider =
    StateNotifierProvider<PageScreenSettingsNotifier, bool>(
  (ref) => PageScreenSettingsNotifier(),
);
