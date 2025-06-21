import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../home_screen/model/buttomBar_model.dart';
import '../../widgets/appBarWidget.dart';

class NotesContentDetialScreen extends StatefulWidget {
  NotesContentDetialScreen({required this.language, required this.selectClassName, required this.selectChapterName, super.key, required this.tabtype});
  final String language;
  final String selectClassName;
  final String selectChapterName;
  final String tabtype;

  @override
  State<NotesContentDetialScreen> createState() => _VideoContentDetailScreenState();
}

class _VideoContentDetailScreenState extends State<NotesContentDetialScreen> {
  String pdfUrl = 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf';

  final List<BottomNavItemModel> navItems = [BottomNavItemModel(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'), BottomNavItemModel(icon: Icons.rss_feed_outlined, activeIcon: Icons.rss_feed, label: 'Feedback'), BottomNavItemModel(icon: Icons.phone_outlined, activeIcon: Icons.phone, label: 'Contact'), BottomNavItemModel(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile')];

  @override
  Widget build(BuildContext context) {
    var indexget = widget.selectClassName.indexOf('h');
    print(indexget);
    final media = MediaQuery.of(context).size;
    return Scaffold(appBar: AppBarWidget(appTitle: '${widget.selectClassName.substring(0, indexget + 1)} ${widget.tabtype}'), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: SfPdfViewer.network(pdfUrl)));
  }
}
