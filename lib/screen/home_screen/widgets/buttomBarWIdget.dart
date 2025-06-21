// ======================== CUSTOM BOTTOM NAVIGATION WIDGET ========================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/BottomNav/bottom_nav_bloc.dart';
import '../blocs/BottomNav/bottom_nav_event.dart';
import '../blocs/BottomNav/bottom_nav_state.dart';
import '../model/buttomBar_model.dart';

class CustomBottomNavigation extends StatelessWidget {
  final List<BottomNavItemModel> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? elevation;
  final EdgeInsets? padding;
  final double? height;
  final BorderRadius? borderRadius;
  final Function(int index, String tabName)? onItemTapped;
  final bool showLabels;
  final double? iconSize;
  final TextStyle? labelStyle;
  final bool enableHapticFeedback;

  const CustomBottomNavigation({super.key, required this.items, this.backgroundColor, this.selectedItemColor, this.unselectedItemColor, this.elevation, this.padding, this.height, this.borderRadius, this.onItemTapped, this.showLabels = true, this.iconSize, this.labelStyle, this.enableHapticFeedback = true});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isTablet = screenWidth > 600;

    // Default values with responsive design
    final defaultHeight = height ?? (isTablet ? 85.0 : 75.0);
    final defaultIconSize = iconSize ?? (isTablet ? 28.0 : 24.0);
    final defaultPadding = padding ?? EdgeInsets.symmetric(horizontal: isTablet ? 20.0 : 16.0, vertical: isTablet ? 12.0 : 8.0);

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final bloc = context.read<BottomNavBloc>();

        return Container(
          decoration: BoxDecoration(color: backgroundColor ?? Colors.white, borderRadius: borderRadius ?? BorderRadius.only(topLeft: Radius.circular(isTablet ? 25 : 20), topRight: Radius.circular(isTablet ? 25 : 20)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: elevation ?? 15, offset: Offset(0, -5), spreadRadius: 0)]),
          child: SafeArea(
            child: Container(
              height: defaultHeight,
              padding: defaultPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = bloc.currentIndex == index;

                      return _buildNavItem(context, item, index, isSelected, defaultIconSize, isTablet);
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, BottomNavItemModel item, int index, bool isSelected, double iconSize, bool isTablet) {
    final selectedColor = selectedItemColor ?? Color(0xFF7C3AED);
    final unselectedColor = unselectedItemColor ?? Colors.black45;
    final media = MediaQuery.of(context).size;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (enableHapticFeedback) {
            // Add haptic feedback
            _performHapticFeedback();
          }

          // Trigger BLoC event
          context.read<BottomNavBloc>().add(BottomNavItemTapped(index, item.label));

          // Call custom onTap if provided
          if (item.onTap != null) {
            item.onTap!();
          }

          // Call parent onItemTapped if provided
          if (onItemTapped != null) {
            onItemTapped!(index, item.label);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),

          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: isTablet ? 8.0 : 6.0),
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with animation
                AnimatedContainer(
                  // height: media.height * 0.,
                  width: media.width * 0.16,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(isSelected ? 4.0 : 0.0),
                  decoration: BoxDecoration(color: isSelected ? selectedColor.withOpacity(0.1) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Icon(isSelected && item.activeIcon != null ? item.activeIcon! : item.icon, size: iconSize, color: isSelected ? (item.color ?? selectedColor) : unselectedColor),
                      if (showLabels) ...[SizedBox(height: isTablet ? 6.0 : 0), AnimatedDefaultTextStyle(duration: Duration(milliseconds: 200), curve: Curves.easeInOut, style: (labelStyle ?? TextStyle()).copyWith(color: isSelected ? (item.color ?? selectedColor) : unselectedColor, fontSize: isTablet ? 14.0 : 12.0, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400), child: Text(item.label, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis))],
                    ],
                  ),
                ),

                // Label with animation
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _performHapticFeedback() {
    // You can implement haptic feedback here
    // For example: HapticFeedback.lightImpact();
  }
}
