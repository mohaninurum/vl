import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

class TypeButton extends StatelessWidget {
  final type;
  final Widget icon;
  final isSelected;
  TypeButton({super.key, this.type, required this.icon, this.isSelected});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: AppColors.appWhiteColor, blurRadius: 2.0)], color: AppColors.pramarycolor1, borderRadius: BorderRadius.circular(30), border: Border.all(width: isSelected ? 3 : 0, color: isSelected ? Colors.white : Colors.white30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: width * 0.6,
            height: 50,
            decoration: BoxDecoration(color: AppColors.pramarycolor1),
            child: Stack(
              children: [
                // Background Layer
                Positioned.fill(child: CustomPaint(painter: DiagonalSplitPainter())),

                // Text and Icon Layer
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Padding(padding: EdgeInsets.only(left: 20), child: Text(type, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1.2))), Container(alignment: Alignment.centerLeft, width: 30, height: 50, decoration: const BoxDecoration(color: AppColors.pramarycolor1), child: icon)]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiagonalSplitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.pramarycolor;

    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width * 0.75, 0)
          ..lineTo(size.width * 0.6, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
