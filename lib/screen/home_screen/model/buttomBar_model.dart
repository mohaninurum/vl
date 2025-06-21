import 'package:flutter/cupertino.dart';

class BottomNavItemModel {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  BottomNavItemModel({required this.icon, this.activeIcon, required this.label, this.color, this.onTap});
}
