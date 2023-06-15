import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  final void Function(String value) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.done,
        onChanged: onChanged,
        autofocus: true,
        decoration: InputDecoration(
          prefixIcon: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          suffixIcon: IconButton(
              onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
              icon: const Icon(Icons.search)),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }
}
