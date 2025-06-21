// import 'package:flutter/material.dart';
//
// class GradientLanguageToggle extends StatelessWidget {
//   final bool isEnglishSelected;
//   final VoidCallback onToggle;
//
//   const GradientLanguageToggle({super.key, required this.isEnglishSelected, required this.onToggle});
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(duration: const Duration(milliseconds: 300), width: width * 0.4, height: 40, padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: isEnglishSelected ? const LinearGradient(colors: [Color(0xFF5B0D9A), Color(0xFFE180FF)]) : const LinearGradient(colors: [Colors.grey, Colors.grey])), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(isEnglishSelected ? "English" : "Hindi", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), Switch(value: isEnglishSelected, onChanged: onToggle)]));
//   }
// }
