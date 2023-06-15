import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/providers/page_screen_settings.dart';
import 'package:popover/popover.dart';

class ViewMorePopOver extends ConsumerWidget {
  const ViewMorePopOver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => _openPopOver(context, ref),
      icon: const Icon(Icons.more_vert),
    );
  }

  Future<void> _openPopOver(BuildContext context, WidgetRef ref) {
    final isNewToOld = ref.watch(pageScreenSettingsProvider);

    return showPopover(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.background,
      bodyBuilder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
              onPressed: () {},
              icon: Icons.playlist_add_check_rounded,
              title: 'Select All',
              context: context),
          _buildButton(
              onPressed: () {
                ref.read(pageScreenSettingsProvider.notifier).toggleSortBy();
                Navigator.pop(context);
              },
              icon: Icons.sort_rounded,
              title: isNewToOld ? 'Old to New' : 'New To Old',
              context: context),
        ],
      ),
      direction: PopoverDirection.bottom,
      // contentDyOffset: 20,
      arrowHeight: 0,
      arrowWidth: 0,
      // height: 200,
    );
  }

  Widget _buildButton({onPressed, icon, title, context}) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      label: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
