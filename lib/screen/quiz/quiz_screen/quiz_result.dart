import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/screen/quiz/quiz_screen/quiz_review_screen.dart';

import '../../widgets/appBarWidget.dart';
import '../models/question_model.dart'; // adjust path accordingly

class QuizResultScreen extends StatelessWidget {
  final List<QuestionModel> questions;
  final List<int> selectedAnswers;

  const QuizResultScreen({super.key, required this.questions, required this.selectedAnswers});

  @override
  Widget build(BuildContext context) {
    print("Select Ans");
    print(selectedAnswers);
    final correct = selectedAnswers.asMap().entries.where((entry) => entry.key < questions.length && entry.value == questions[entry.key].correctIndex).length;

    final wrong = questions.length - correct;
    final percent = (correct / questions.length) * 100;
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(appTitle: 'Your Quiz Result'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResultCard(correct, wrong, questions.length, percent),
            const SizedBox(height: 30),
            _buildActionButton(
              text: "Review All Answers",
              color: AppColors.pramarycolor,
              icon: Icons.visibility,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => QuizReviewScreen(questions: questions, selectedAnswers: selectedAnswers)));
                // Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(isPreview: true, id: '1', language: "", selectChapterName: "", selectClassesName: "", tabtype: "")));
              },
            ),
            const SizedBox(height: 16),
            // _buildActionButton(text: "Back", color: Colors.grey, icon: Icons.arrow_back, onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(int correct, int wrong, int total, double percent) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.pramarycolor1, AppColors.pramarycolor], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.teal.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Performance", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildStatRow("Total Questions", total.toString()),
          _buildStatRow("Correct Answers", "$correct ✅", color: Colors.lightGreenAccent),
          _buildStatRow("Wrong Answers", "$wrong ❌", color: Colors.redAccent.shade100),
          const SizedBox(height: 20),
          const Text("Score", style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percent),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Stack(alignment: Alignment.center, children: [LinearProgressIndicator(value: value / 100, minHeight: 18, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation<Color>(Colors.white), borderRadius: BorderRadius.circular(10)), Text("${value.toInt()}%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String title, String value, {Color? color}) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 16, color: Colors.white70)), Text(value, style: TextStyle(fontSize: 16, color: color ?? Colors.white, fontWeight: FontWeight.bold))]));
  }

  Widget _buildActionButton({required String text, required Color color, required IconData icon, required VoidCallback onTap}) {
    return SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 6, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), icon: Icon(icon, color: Colors.white), label: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16))));
  }
}
