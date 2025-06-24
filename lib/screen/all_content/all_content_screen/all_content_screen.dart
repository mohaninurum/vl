import 'package:flutter/material.dart';

import '../../home_screen/model/buttomBar_model.dart';
import '../../widgets/appBarWidget.dart';
import '../widgets/all_content_widget.dart';

class AllContentScreen extends StatelessWidget {
  AllContentScreen({required this.language, required this.selectClassName, required this.selectChapterName, super.key, required this.id});
  final String language;
  final String selectClassName;
  final String selectChapterName;
  final String id;
  final List<BottomNavItemModel> navItems = [BottomNavItemModel(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'), BottomNavItemModel(icon: Icons.rss_feed_outlined, activeIcon: Icons.rss_feed, label: 'Feedback'), BottomNavItemModel(icon: Icons.phone_outlined, activeIcon: Icons.phone, label: 'Contact'), BottomNavItemModel(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile')];
  // final List<ChapterContentModel> items = [
  //  // ChapterContentModel(imageUrl: 'assets/images/motion1.png', title: '1. Motion', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.deepPurple, gradeLangEn: ''),
  //
  //
  // ];
  // final chapters = [
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: '1. Motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9वीं हिंदी', bgColor: Colors.grey.shade200),
  //   // Add more...
  // ];
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(appBar: AppBarWidget(), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: media.width * 0.04), child: AllContentWidget(id: id, language: language, selectClassesName: selectClassName, selectChapterName: selectChapterName))));
  }
}
