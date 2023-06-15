import 'package:flutter/material.dart';

void showAlertDialog({
  required context,
  required void Function() action,
  required content,
  title = 'Confirmation',
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            action();
            Navigator.pop(ctx);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
