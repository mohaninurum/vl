import 'package:flutter/material.dart';

import '../../screen/home_screen/widgets/search_bar.dart';
import '../../screen/notifications/notifications_screen/notifications_screen.dart';
import '../app_colors/app_colors.dart';
import '../app_string/app_string.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext parentContext;

  const CustomAppBar({super.key, required this.parentContext});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: media.width * 0.03, vertical: media.height * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleWidget(media),
            SizedBox(width: media.width * 0.01),
            Image.asset('assets/appicons/Visuallearning trans.png', height: media.height * 0.07),
            SizedBox(width: media.width * 0.01),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(AppString.welcomeToText, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.appBlack54Color)), Text(AppString.visualLearningText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.pramarycolor))]),
            const Spacer(),
            InkWell(
              onTap: () {
                showSearch(context: parentContext, delegate: CustomSearchDelegate());
              },
              child: Container(padding: EdgeInsets.all(media.height * 0.01), decoration: const BoxDecoration(color: AppColors.pramarycolor, shape: BoxShape.circle), child: const Icon(Icons.search, color: Colors.white)),
            ),
            SizedBox(width: media.width * 0.02),
            InkWell(
              onTap: () {
                Navigator.push(parentContext, MaterialPageRoute(builder: (_) => NotificationScreen()));
              },
              child: Icon(Icons.circle_notifications, size: 40, color: AppColors.pramarycolor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget(Size media) {
    return Padding(padding: EdgeInsets.only(right: media.width * 0.02), child: Icon(Icons.menu, size: 30, color: AppColors.pramarycolor));
  }
}
