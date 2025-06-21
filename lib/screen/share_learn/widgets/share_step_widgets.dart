import 'package:flutter/material.dart';

class ShareStepTile extends StatelessWidget {
  final int number;
  final Color color;
  final String text;
  final IconData icon;

  const ShareStepTile({required this.number, required this.color, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Row(children: [CircleAvatar(backgroundColor: color, child: Text('$number', style: const TextStyle(color: Colors.white))), const SizedBox(width: 12), Expanded(child: Text(text, style: const TextStyle(fontSize: 14))), Icon(icon, color: color)]));
  }
}
