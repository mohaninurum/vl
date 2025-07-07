import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

class InfoDialog {
  static Future<void> showHindiNotAvailable(BuildContext context, language) async {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.pramarycolor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),

          title: Row(children: [Icon(Icons.info_outline, color: AppColors.pramarycolor), const SizedBox(width: 8), Expanded(child: Text("Notice", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)))]),

          content: Text("This video is not available in $language.", style: TextStyle(color: Colors.white, fontSize: 15)),

          actions: [SizedBox(width: screenWidth * 0.3, child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(side: BorderSide(color: AppColors.appWhiteColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("Close", style: TextStyle(color: AppColors.appWhiteColor))))],
        );
      },
    );
  }
}
