import 'package:flutter/material.dart';
import 'package:ink/utility/container_selctor/container_selector_controller.dart';

class ContainerSelectorBuilder<T> extends StatefulWidget {
  const ContainerSelectorBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(
      BuildContext context, ContainerSelectorController<T> controller) builder;

  @override
  State<ContainerSelectorBuilder<T>> createState() =>
      _ContainerSelectorBuilderState<T>();
}

class _ContainerSelectorBuilderState<T>
    extends State<ContainerSelectorBuilder<T>> {
  late ContainerSelectorController<T> controller;
  late List<T> selectedTags;

  void onChnage() {
    setState(() {
      selectedTags = controller.selectedTags;
    });
  }

  @override
  void initState() {
    controller = ContainerSelectorController<T>();
    selectedTags = controller.selectedTags;
    controller.addListener(onChnage);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onChnage);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      controller,
    );
  }
}
