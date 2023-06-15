// import 'package:ink/models/page_info.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SelectedPageNotifier extends StateNotifier<List<PageInfo>> {
//   SelectedPageNotifier() : super(<PageInfo>[]);

//   void togglePage(PageInfo selectedPageInfo) {
//     bool isExist = state.contains(selectedPageInfo);
//     if (isExist) {
//       state = state.where((page) => page != selectedPageInfo).toList();
//     } else {
//       state = [selectedPageInfo, ...state];
//     }
//   }

//   void removeAll() {
//     state = [];
//   }

//   void setAll(List<PageInfo> selectedPages) {
//     state = selectedPages;
//   }
// }

// final selectedPageProvider =
//     StateNotifierProvider<SelectedPageNotifier, List<PageInfo>>(
//   (ref) => SelectedPageNotifier(),
// );
