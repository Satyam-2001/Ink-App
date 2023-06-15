import 'package:flutter/material.dart';
import 'package:ink/utility/container_selctor/container_selector_controller.dart';

class ContainerSelector<T> extends StatefulWidget {
  const ContainerSelector({
    super.key,
    required this.tag,
    this.child,
    this.colorOnSelected,
    this.onTap,
    required this.controller,
    this.elevation = 0.0,
    this.radius = 0.0,
    this.widgetOnTop,
  });

  ContainerSelector.icon({
    super.key,
    required this.tag,
    this.child,
    this.colorOnSelected,
    this.onTap,
    required this.controller,
    this.elevation = 0.0,
    this.radius = 0.0,
    required final Icon icon,
  }) : widgetOnTop = Center(child: icon);

  final ContainerSelectorController? controller;
  final T tag;
  final Widget? child;
  final Color? colorOnSelected;
  final void Function()? onTap;
  final double elevation;
  final double radius;
  final Widget? widgetOnTop;

  @override
  State<ContainerSelector> createState() => _ContainerSelectorState();
}

class _ContainerSelectorState extends State<ContainerSelector> {
  late ContainerSelectorController _controller;
  late bool isSelected;
  late bool isAnySelected;

  @override
  void initState() {
    _controller = widget.controller ?? ContainerSelectorController();
    isAnySelected = _controller.isAnySelected;
    isSelected = _controller.conatins(widget.tag);
    _controller.addListener(onChange);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? foregroundColor;
    if (isSelected) {
      foregroundColor = widget.colorOnSelected ??
          Theme.of(context).colorScheme.primary.withOpacity(0.4);
    }

    return Card(
      elevation: widget.elevation,
      child: InkWell(
        onTap: _handleTapEvent,
        onLongPress: _toggleTag,
        child: Stack(
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                color: foregroundColor,
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }

  void onChange() {
    setState(() {
      isAnySelected = _controller.isAnySelected;
      isSelected = _controller.conatins(widget.tag);
    });
  }

  void _handleTapEvent() {
    if (isAnySelected) {
      _toggleTag();
    } else if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _toggleTag() => _controller.toggleTag(widget.tag);
}
