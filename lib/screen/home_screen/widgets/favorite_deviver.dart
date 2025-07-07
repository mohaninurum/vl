import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

class FavoriteDeviver extends StatelessWidget {
  FavoriteDeviver({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(color: AppColors.pramarycolor1),
          child: Stack(
            children: [
              // Background Layer
              Positioned.fill(child: CustomPaint(painter: DiagonalSplitPainter())),

              // Text and Icon Layer
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Padding(padding: EdgeInsets.only(left: 20), child: Text("Favorite", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1.2))), Container(alignment: Alignment.centerLeft, width: 30, height: 50, decoration: const BoxDecoration(color: AppColors.pramarycolor1), child: Icon(Icons.favorite, color: Colors.white))]),
            ],
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
