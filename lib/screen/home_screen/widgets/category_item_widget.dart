import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final bool comingSoon;
  final VoidCallback onTap;
  final String language;

  const CategoryItem({required this.language, required this.title, required this.image, this.comingSoon = false, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      onTap: comingSoon ? null : onTap,
      child: Stack(
        children: [
          Container(
            width: media.width * 01,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            padding: EdgeInsets.all(media.height * 0.017),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [title.isNotEmpty ? Image.asset(image, height: media.height * 0.11) : CachedNetworkImage(fit: BoxFit.cover, height: media.height * 0.11, imageUrl: image, placeholder: (context, url) => Center(child: CircularProgressIndicator()), errorWidget: (context, url, error) => Icon(Icons.error)), SizedBox(height: media.height * 0.01), Text(title, style: TextStyle(color: AppTextColors.appTextColorWhite, fontWeight: FontWeight.w600)), language.isNotEmpty ? Text("($language)", style: TextStyle(color: AppTextColors.appTextColorWhite, fontWeight: FontWeight.w600, fontSize: 10)) : SizedBox.shrink()]),
          ),
          if (comingSoon) Center(child: Padding(padding: const EdgeInsets.all(30), child: Container(height: 40, width: 200, decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(16)), alignment: Alignment.center, child: const Text('Coming Soon', style: TextStyle(color: AppTextColors.appTextColorWhite, fontWeight: FontWeight.bold))))),
        ],
      ),
    );
  }
}
