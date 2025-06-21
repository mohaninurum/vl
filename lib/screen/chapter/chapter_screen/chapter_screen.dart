import 'package:flutter/material.dart';
import 'package:visual_learning/screen/widgets/chapter_widgets.dart';

import '../../home_screen/model/buttomBar_model.dart';
import '../../widgets/appBarWidget.dart';

class ChapterScreen extends StatelessWidget {
  final String language;
  final String selectClassName;
  ChapterScreen({required this.language, required this.selectClassName, super.key});
  final List<BottomNavItemModel> navItems = [BottomNavItemModel(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'), BottomNavItemModel(icon: Icons.rss_feed_outlined, activeIcon: Icons.rss_feed, label: 'Feedback'), BottomNavItemModel(icon: Icons.phone_outlined, activeIcon: Icons.phone, label: 'Contact'), BottomNavItemModel(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile')];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    print("height Screen chapter screen ${media.height}");
    return Scaffold(appBar: AppBarWidget(), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01), child: ChapterWidgets(language: language, selectClassesName: selectClassName))));
  }
}
