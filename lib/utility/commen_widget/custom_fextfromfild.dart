
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextFormField({super.key, 
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text, required bool obscureText,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    _obscureTextNotifier.value = !_obscureTextNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, obscureText, child) {
        return TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
            errorStyle: const TextStyle(color: Colors.red),
            suffixIcon: widget.keyboardType == TextInputType.visiblePassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
          ),
          obscureText: obscureText,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
        );
      },
    );
  }
}
