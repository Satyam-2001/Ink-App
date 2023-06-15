import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/letter_image.dart';
import 'package:ink/models/letters.dart';
import 'package:ink/providers/letters.dart';
import 'package:ink/screens/text/letter_edit.dart';
import 'package:ink/screens/text/single_letter.dart';
import 'package:ink/widgets/text/letter_image_block.dart';

class LettersListItem extends ConsumerStatefulWidget {
  const LettersListItem({super.key, required this.value});

  final Letter value;

  @override
  ConsumerState<LettersListItem> createState() => _LettersListItemState();
}

class _LettersListItemState extends ConsumerState<LettersListItem> {
  List<LetterImage> lettersImageList = [];

  @override
  Widget build(BuildContext context) {
    lettersImageList = ref
        .watch(lettersProvider)
        .where(
            (letterImage) => letterImage.letter == widget.value.name.toString())
        .toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => SingleLetterScreen(letter: widget.value)));
          },
          child: Text(
            LettteToText[widget.value]!.text,
            textScaleFactor: 1.3,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var letter in lettersImageList)
                  LettersImageBlock(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) =>
                                LetterEditScreen(letterImageObject: letter)),
                      );
                    },
                    letterImage: letter,
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(4),
                    size: 40,
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
