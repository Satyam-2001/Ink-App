import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContainerSelectorController<T>
    extends ValueNotifier<ContainerSelectorValue<T>> {
  ContainerSelectorController() : super(ContainerSelectorValue<T>());

  List<T> get selectedTags => value.selectedTags;
  bool get isAnySelected => value.selectedTags.isNotEmpty;

  set selectedTags(List<T>? tagsList) {
    value = ContainerSelectorValue<T>(selectedTags: tagsList ?? []);
  }

  bool conatins(T tag) {
    return value.selectedTags.contains(tag);
  }

  void toggleTag(T tag) {
    if (conatins(tag)) {
      _removeTag(tag);
    } else {
      _addTag(tag);
    }
  }

  void _addTag(T tag) {
    value = ContainerSelectorValue<T>(
      selectedTags: [...value.selectedTags, tag],
    );
  }

  void _removeTag(T tag) {
    List<T> newTagsList = [...value.selectedTags];
    newTagsList.remove(tag);
    value = ContainerSelectorValue<T>(
      selectedTags: newTagsList,
    );
  }
}

@immutable
class ContainerSelectorValue<T> {
  const ContainerSelectorValue({
    this.selectedTags = const [],
  });
  final List<T> selectedTags;
}
