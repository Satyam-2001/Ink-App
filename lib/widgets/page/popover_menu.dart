import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class PopOverMenu extends StatelessWidget {
  const PopOverMenu({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _openPopOver(context, children),
      icon: const Icon(Icons.more_vert),
    );
  }

  Future<void> _openPopOver(BuildContext context, List<Widget> children) {
    return showPopover(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.background,
      bodyBuilder: (context) =>
          Column(mainAxisSize: MainAxisSize.min, children: children),
      direction: PopoverDirection.bottom,
      arrowHeight: 0,
      arrowWidth: 0,
    );
  }
}

class PopOverMenuItem extends StatelessWidget {
  const PopOverMenuItem({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });

  final void Function() onPressed;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
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
