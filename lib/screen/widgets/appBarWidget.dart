import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/constant/app_text_colors/app_text_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String? appTitle;
  String? backarrow;
  AppBarWidget({this.appTitle, Key? key, this.backarrow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: AppColors.pramarycolor, title: Text(appTitle == null ? "" : "$appTitle", style: TextStyle(color: AppTextColors.appTextColorWhite)), centerTitle: true, leading: backarrow == null ? IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.of(context).pop()) : SizedBox());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
