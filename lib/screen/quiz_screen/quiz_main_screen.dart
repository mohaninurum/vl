import 'package:flutter/material.dart';

import '../widgets/appBarWidget.dart';

class QuizMainScreen extends StatelessWidget {
  const QuizMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFF5F5F9), appBar: AppBarWidget(appTitle: ''), body: Column(children: []));
  }
}
