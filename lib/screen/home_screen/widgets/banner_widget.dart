import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_text_colors/app_text_colors.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';

class BannerWidget extends StatelessWidget {
  String categoryName;
  String screenName;
  BannerWidget({required this.categoryName, required this.screenName, super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      padding: EdgeInsets.all(media.width * 0.04),
      child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(categoryName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 20, fontWeight: FontWeight.w600)), screenName.isNotEmpty ? Text(AppString.videoAllClassesText, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 12, fontWeight: FontWeight.w600)) : SizedBox.shrink()])),
          const SizedBox(width: 10),
          Image.asset('assets/appicons/icon5Asset 5.png', height: media.height * 0.12),
        ],
      ),
    );
  }
}
