import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../screen/subcriptions/subcriptions_screen.dart';

class SubscriptionDialog {
  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        final screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          backgroundColor: AppColors.pramarycolor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          title: Row(children: [Icon(Icons.lock_outline, color: Colors.white), const SizedBox(width: 8), Text("Subscription Required", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white))]),
          content: Column(mainAxisSize: MainAxisSize.min, children: [const SizedBox(height: 8), Text("This content is available for subscribed users only. Please subscribe to continue.", style: TextStyle(color: Colors.white)), const SizedBox(height: 20)]),
          actions: [
            SizedBox(
              width: screenWidth * 0.25,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
                label: const Text("Cancel"),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.4,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SubscriptionScreen()));
                },
                icon: const Icon(Icons.subscriptions),
                label: const Text("Subscribe Now"),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ],
        );
      },
    );
  }
}
