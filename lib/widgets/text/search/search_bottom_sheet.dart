import 'package:flutter/material.dart';
import 'package:ink/models/letters.dart';
import 'package:ink/widgets/text/letters_list_item.dart';
import 'package:ink/widgets/text/search/search_bar.dart';

class SuggestionListItem extends StatelessWidget {
  const SuggestionListItem({
    super.key,
    required this.value,
    required this.onTap,
  });
  final String value;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: Colors.black12,
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final List<String> suggestinList = [
    'numbers',
    'lowercase',
    'uppercase',
    'special character'
  ];
  final controller = TextEditingController();
  String seachedValue = '';

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        seachedValue = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Letter> searchedElement = [];

    if (seachedValue.isNotEmpty) {
      searchedElement = Letter.values
          .where((letter) => LettteToText[letter]!.isMatch(seachedValue))
          .toList();
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomSearchBar(
            controller: controller,
            onChanged: (value) {
              setState(() {
                seachedValue = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black12,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Suggestions',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Wrap(
                  children: suggestinList
                      .map((value) => SuggestionListItem(
                          value: value,
                          onTap: () {
                            controller.text = value;
                            FocusManager.instance.primaryFocus?.unfocus();
                          }))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              primary: false,
              itemCount: searchedElement.length,
              itemBuilder: (ctx, index) =>
                  LettersListItem(value: searchedElement[index]),
            ),
          ),
        ],
      ),
    );
  }
}
