import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/appBarWidget.dart';

class PdfViewWidgets extends StatelessWidget {
  const PdfViewWidgets({super.key, required this.pdgUrl});
  final String pdgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarWidget(appTitle: "PDF"), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: SfPdfViewer.network(pdgUrl)));
  }
}
