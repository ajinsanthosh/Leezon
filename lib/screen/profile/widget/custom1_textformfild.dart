import 'package:flutter/material.dart';

class OutlineTextformfild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType; // Added parameter for keyboard type

  const OutlineTextformfild({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,  // Default to TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: const Color.fromARGB(255, 61, 60, 60),
      keyboardType: keyboardType, // Set keyboard type
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 150, 150, 150), // Optional: style for hint text
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 61, 60, 60),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 12, 3, 47),
            width: 2,
          ),
        ),
      ),
    );
  }
}
