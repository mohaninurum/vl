import 'package:flutter/material.dart';

class HelpOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const HelpOptionTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(border: Border.all(color: Colors.black54), borderRadius: BorderRadius.circular(8)), child: Icon(icon, size: 20)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle navigation or action
      },
    );
  }
}
