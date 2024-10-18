import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final bool readOnly;
  final String? suffixText;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText = '',
    this.obscureText = false,
    this.readOnly = false,
    this.suffixText,
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey[50],
        floatingLabelStyle: TextStyle(color: Colors.grey[150]),
        labelStyle: TextStyle(color: Colors.grey[150]),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          borderRadius: BorderRadius.circular(10.0)
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5)
        ),
        suffix: suffixText == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(suffixText!),
                const SizedBox(width: 8),
              ],
            ),
      ),
    );
  }
}

/*                   suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('@example.com'),
                      SizedBox(width: 8),
                    ],
                  ), */