import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/letter_image.dart';
import 'package:ink/models/letters.dart';
import 'package:ink/providers/letters.dart';
import 'package:ink/screens/text/letter_edit.dart';
import 'package:ink/utility/alert_dialog.dart';
import 'package:ink/widgets/text/letter_image_block.dart';

class SingleLetterScreen extends ConsumerStatefulWidget {
  SingleLetterScreen({super.key, required this.letter})
      : obj = LettteToText[letter]!,
        text = LettteToText[letter]!.text;

  final Letter letter;
  final LetterClass obj;
  final String text;

  @override
  ConsumerState<SingleLetterScreen> createState() => _SingleLetterScreenState();
}

class _SingleLetterScreenState extends ConsumerState<SingleLetterScreen> {
  List<LetterImage> _selectedLetterImagesList = [];
  late List<LetterImage> letterImageList;

  @override
  void initState() {
    letterImageList = ref
        .read(lettersProvider)
        .where((letterImage) => letterImage.letter == widget.text)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelectedAny = _selectedLetterImagesList.isNotEmpty;
    final selctedListCount = _selectedLetterImagesList.length;

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black54,
        title: isSelectedAny
            ? Text('$selctedListCount Selected')
            : _letterAppBarTile,
        actions: [
          isSelectedAny
              ? IconButton(
                  onPressed: _deleteHandler, icon: const Icon(Icons.delete))
              : IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: _buildBody,
    );
  }

  Widget get _letterAppBarTile {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 1,
                blurRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Text(widget.obj.text),
        ),
      ],
    );
  }

  Widget get _buildBody {
    if (letterImageList.isEmpty) {
      return Center(
        child: Text(
          'Oops! Nothing Found',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
          ),
        ),
      );
    }

    return GridView(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      children: [
        for (var obj in letterImageList)
          _letterImageBlock(obj, _selectedLetterImagesList.contains(obj))
      ],
    );
  }

  Widget _letterImageBlock(LetterImage imageObj, bool isSelected) {
    return LettersImageBlock(
      letterImage: imageObj,
      onTap: () => _tapHandler(imageObj),
      onLongPress: () => _toggleSelectedItem(imageObj),
      isSelected: isSelected,
    );
  }

  void _tapHandler(LetterImage obj) {
    if (_selectedLetterImagesList.isNotEmpty) {
      _toggleSelectedItem(obj);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LetterEditScreen(letterImageObject: obj),
      ),
    );
  }

  void _toggleSelectedItem(LetterImage obj) {
    if (_selectedLetterImagesList.contains(obj)) {
      setState(() {
        _selectedLetterImagesList.remove(obj);
      });
    } else {
      setState(() {
        _selectedLetterImagesList.add(obj);
      });
    }
  }

  void _deleteHandler() async {
    showAlertDialog(
      context: context,
      action: () {
        ref.read(lettersProvider.notifier).removeAll(_selectedLetterImagesList);
        setState(() {
          letterImageList
              .removeWhere((obj) => _selectedLetterImagesList.contains(obj));
          _selectedLetterImagesList.removeRange(
              0, _selectedLetterImagesList.length);
        });
      },
      content: 'Doy you want to delete selected letters?',
    );
  }
}
