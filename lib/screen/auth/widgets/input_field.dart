import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool isPaswordShow;
  final void Function(String)? onChanged;
  final String? errorText;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType;
  const InputField({super.key, this.keyboardType, required this.hintText, required this.isPaswordShow, this.obscureText = false, this.onChanged, this.errorText, this.onSuffixTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        isDense: true, // Reduces vertical padding
        errorText: errorText,
        filled: true,
        fillColor: Colors.white,
        labelText: hintText,
        suffixIcon: (hintText == "Password" || hintText == "Confirm Password") ? InkWell(onTap: onSuffixTap, child: Icon(isPaswordShow ? Icons.visibility : Icons.visibility_off)) : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13), // Reduce vertical padding
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.deepPurple, width: 2)),
      ),
    );
  }
}
