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
    print("height Screen chapter screen ${media.height}");
    return Scaffold(appBar: AppBarWidget(), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01), child: ChapterWidgets(id: selectClassName, language: language, selectClassesName: selectClassName))));
  }
}
