import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/page_info.dart';
import 'package:ink/providers/page_info_list.dart';
import 'package:ink/screens/page/add_page.dart';
import 'package:ink/utility/alert_dialog.dart';
import 'package:ink/utility/container_selctor/container_selector_builder.dart';
import 'package:ink/widgets/main_drawer.dart';
import 'package:ink/widgets/page/page_list.dart';
import 'package:ink/widgets/page/view_more_popover.dart';

class PagesScreen extends ConsumerStatefulWidget {
  const PagesScreen({super.key, required this.setScreen});
  final void Function(String identifier) setScreen;

  @override
  ConsumerState<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends ConsumerState<PagesScreen> {
  @override
  Widget build(BuildContext context) {
    return ContainerSelectorBuilder<PageInfo>(
      builder: (ctx, controller) {
        void deleteSelectedPages() {
          ref
              .read(pageInfoListProvider.notifier)
              .removeSelectedPages(controller.selectedTags);
          controller.selectedTags = [];
        }

        AppBar appBar = AppBar(
          elevation: 4,
          shadowColor: Colors.black54,
          title: const Text('Pages'),
          actions: const [
            ViewMorePopOver(),
          ],
        );

        if (controller.selectedTags.isNotEmpty) {
          appBar = AppBar(
            elevation: 4,
            shadowColor: Colors.black54,
            title: Text('${controller.selectedTags.length} selected'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                controller.selectedTags = [];
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showAlertDialog(
                    context: context,
                    title: 'Confirmation',
                    content: 'You really want to delete this page?',
                    action: deleteSelectedPages,
                  );
                },
                icon: const Icon(Icons.delete),
              )
            ],
          );
        }

        final isPagesExist = ref.watch(pageInfoListProvider).isNotEmpty;

        Widget content = Center(
          child: Text(
            'Oops! No Pages Found',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
            ),
          ),
        );

        if (isPagesExist) {
          content = PageList(controller: controller);
        }
        return Scaffold(
          appBar: appBar,
          drawer: MainDrawer(setScreen: widget.setScreen),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: content,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPageScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
