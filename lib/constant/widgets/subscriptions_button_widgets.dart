import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../screen/subcriptions/subcriptions_screen.dart';

class SubscriptionsButtonWidgets extends StatelessWidget {
  const SubscriptionsButtonWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("This content is available for subscribed users only.", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          SizedBox(
            width: screenWidth * 0.4,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => SubscriptionScreen()));
              },
              icon: const Icon(Icons.subscriptions, color: Colors.white),
              label: const Text("Subscribe Now", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }
}
