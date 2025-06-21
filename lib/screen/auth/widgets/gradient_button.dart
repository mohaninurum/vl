import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;

  const GradientButton({super.key, required this.text, required this.onPressed, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: 48, decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(30)), child: MaterialButton(onPressed: onPressed, child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16))));
  }
}
