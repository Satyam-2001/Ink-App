import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelecteTabNotifier extends StateNotifier<int> {
  SelecteTabNotifier() : super(0);

  void setTab(int value) {
    state = value;
  }
}

final selectTabProvider = StateNotifierProvider<SelecteTabNotifier, int>(
  (ref) => SelecteTabNotifier(),
);
