import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/page_info.dart';
import 'package:ink/providers/page_info_list.dart';
import 'package:ink/utility/container_selctor/container_selector_controller.dart';
import 'package:ink/widgets/page/page_list_item.dart';

class PageList extends ConsumerWidget {
  const PageList({
    super.key,
    required this.controller,
  });

  final ContainerSelectorController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PageInfo> pageInfoList = ref.watch(filteredPageInfoListProvider);

    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      children: [
        for (PageInfo page in pageInfoList)
          PageListItem(
            page: page,
            key: ValueKey(page.id),
            controller: controller,
          ),
      ],
    );
  }
}
