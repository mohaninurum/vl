import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/appBarWidget.dart';

class NotesViewsScreen extends StatefulWidget {
  NotesViewsScreen({super.key, required this.selectName, required this.pdfUrl});

  final String selectName;
  final String pdfUrl;

  @override
  State<NotesViewsScreen> createState() => _NotesViewsScreenState();
}

class _NotesViewsScreenState extends State<NotesViewsScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(appBar: AppBarWidget(appTitle: widget.selectName), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: SfPdfViewer.network(widget.pdfUrl)));
  }
}
