import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CustomButton({super.key, required this.text, required this.onPressed, this.color = Colors.blue, this.textColor = Colors.white, this.borderRadius = 12.0, this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24)});

  @override
  Widget build(BuildContext context) {
    return Center(child: InkWell(onTap: onPressed, child: Container(width: 200, height: 50, alignment: Alignment.center, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)), child: Text(text, style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold)))));
  }
}
