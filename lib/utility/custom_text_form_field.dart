import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.initialValue,
    this.labelText,
    this.icon,
    this.onSaved,
  });

  final String? initialValue;
  final String? labelText;
  final IconData? icon;
  final void Function(String? value)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixText: 'px',
      ),
      validator: (value) {
        if (value == null ||
            value.trim().isEmpty ||
            int.tryParse(value) == null) {
          return 'Please enter a valid $labelText.';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
