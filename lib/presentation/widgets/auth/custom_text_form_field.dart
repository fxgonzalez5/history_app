import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final bool noVisibility;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.label,
    required this.hint,
    this.noVisibility = false,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: noVisibility,
      keyboardType: keyboardType,
      validator: validator,
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