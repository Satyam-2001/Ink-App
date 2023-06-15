import 'package:flutter/material.dart';

void toastMessage({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
