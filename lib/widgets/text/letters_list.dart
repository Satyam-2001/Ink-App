import 'package:flutter/material.dart';
import 'package:ink/models/letters.dart';
import 'package:ink/widgets/text/letters_list_item.dart';

class LettersList extends StatelessWidget {
  const LettersList({super.key});

  final lettersList = Letter.values;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListView.builder(
        itemCount: lettersList.length,
        itemBuilder: (ctx, index) => LettersListItem(value: lettersList[index]),
      ),
    );
  }
}
