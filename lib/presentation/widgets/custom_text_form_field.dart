import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool noVisibility;

  const CustomTextFormField({super.key, required this.label, required this.hint, this.noVisibility = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: noVisibility,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }
}