import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/page_info.dart';
import 'package:ink/providers/page_info_list.dart';
import 'package:ink/utility/alert_dialog.dart';
import 'package:ink/utility/custom_text_form_field.dart';
import 'package:ink/utility/toast_message.dart';
import 'package:ink/widgets/page/image_input.dart';

class AddPageScreen extends ConsumerStatefulWidget {
  const AddPageScreen({super.key}) : page = null;

  const AddPageScreen.edit(
    PageInfo this.page, {
    super.key,
  });

  final PageInfo? page;

  @override
  ConsumerState<AddPageScreen> createState() => _AddPageScreenState();
}

class _AddPageScreenState extends ConsumerState<AddPageScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isDeleteHandlerOpen = false;
  File? _selectedImage;
  int? xpos, ypos, lineHeight;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    if (widget.page == null) {
      return;
    }
    _isEditMode = true;
    _selectedImage = widget.page!.image;
    xpos = widget.page!.xpos;
    ypos = widget.page!.ypos;
    lineHeight = widget.page!.lineHeight;
  }

  void _deletePage() {
    ref.read(pageInfoListProvider.notifier).removePage(widget.page!);
    toastMessage(
      context: context,
      message: 'Page deleted successfully',
    );
    Navigator.of(context).pop();
  }

  void _confirmationDialog() {
    showAlertDialog(
      context: context,
      title: 'Confirmation',
      content: 'You really want to delete this page?',
      action: _deletePage,
    );
  }

  void _submitPageForm() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || _selectedImage == null) {
      return;
    }

    _formKey.currentState!.save();

    if (_isEditMode) {
      ref.read(pageInfoListProvider.notifier).updatePage(
            id: widget.page!.id,
            image: _selectedImage!,
            xpos: xpos!,
            ypos: ypos!,
            lineHeight: lineHeight!,
          );
      toastMessage(
        context: context,
        message: 'Page updated successfully',
      );
    } else {
      ref.read(pageInfoListProvider.notifier).addPage(
            image: _selectedImage!,
            xpos: xpos!,
            ypos: ypos!,
            lineHeight: lineHeight!,
          );
      toastMessage(
        context: context,
        message: 'Page saved successfully',
      );
    }

    Navigator.of(context).pop();
  }

  void _setDeleteHandlerState(bool value) {
    setState(() {
      _isDeleteHandlerOpen = value;
    });
  }

  void _deleteImage() {
    setState(() {
      _isDeleteHandlerOpen = false;
      _selectedImage = null;
    });
  }

  void _setSelectedImage(File? selectedImage) {
    setState(() {
      _selectedImage = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    List<Widget>? action;
    String appBarTitle = 'Add Page';

    if (_isDeleteHandlerOpen) {
      appBarTitle = 'Delete Image';
      action = <Widget>[
        IconButton(
          onPressed: _deleteImage,
          icon: const Icon(Icons.delete),
        ),
        IconButton(
            onPressed: () => _setDeleteHandlerState(false),
            icon: const Icon(Icons.close)),
      ];
    } else if (_isEditMode) {
      appBarTitle = 'Edit Page';
      action = <Widget>[
        IconButton(
            onPressed: _confirmationDialog, icon: const Icon(Icons.delete)),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: action,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  ImageInput(
                      onSelectImage: _setSelectedImage,
                      selectedImage: _selectedImage,
                      isDeleteHandlerOpen: _isDeleteHandlerOpen,
                      setDeleteHandlerState: _setDeleteHandlerState),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                icon: Icons.arrow_right_alt,
                                initialValue:
                                    _isEditMode ? xpos.toString() : null,
                                labelText: 'X Pos',
                                onSaved: (newValue) {
                                  xpos = int.tryParse(newValue!);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTextFormField(
                                icon: Icons.arrow_upward,
                                initialValue:
                                    _isEditMode ? ypos.toString() : null,
                                labelText: 'Y Pos',
                                onSaved: (newValue) {
                                  ypos = int.tryParse(newValue!);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          icon: Icons.format_line_spacing,
                          initialValue:
                              _isEditMode ? lineHeight.toString() : null,
                          labelText: 'Line Height',
                          onSaved: (newValue) {
                            lineHeight = int.tryParse(newValue!);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitPageForm,
                          child: const Text('Save'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
