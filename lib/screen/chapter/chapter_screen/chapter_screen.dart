import 'package:flutter/material.dart';

import '../../widgets/appBarWidget.dart';
import '../widgets/chapter_widgets.dart';

class ChapterScreen extends StatelessWidget {
  final String language;
  final String selectClassName;
  final String id;
  ChapterScreen({required this.language, required this.selectClassName, super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    print("Select Clash ${selectClassName}");

    return Scaffold(appBar: AppBarWidget(), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 13, vertical: 1), child: ChapterWidgets(id: id, language: language, selectClassesName: selectClassName))));
  }
}
