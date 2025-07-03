import 'package:flutter/material.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../widgets/appBarWidget.dart';
import '../models/question_model.dart';

class QuizReviewScreen extends StatefulWidget {
  final List<QuestionModel> questions;
  final List<int> selectedAnswers;

  const QuizReviewScreen({super.key, required this.questions, required this.selectedAnswers});

  @override
  State<QuizReviewScreen> createState() => _QuizReviewScreenState();
}

class _QuizReviewScreenState extends State<QuizReviewScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final q = widget.questions[currentIndex];
    final selectedIndex = widget.selectedAnswers[currentIndex];
    final isCorrect = selectedIndex == q.correctIndex;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(appTitle: "Review Answers"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              // Header with index
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Container(width: media.width * 0.4, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.quizebuttoncolorbluetypecolor, borderRadius: BorderRadius.circular(13)), child: const Text("Question No.", style: TextStyle(color: Colors.white, fontSize: 16))), Container(alignment: Alignment.center, width: media.width * 0.4, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.quizebuttoncolorbluetypecolor, borderRadius: BorderRadius.circular(13)), child: Text("${currentIndex + 1} / ${widget.questions.length}", style: const TextStyle(color: Colors.white, fontSize: 16)))]),
              const SizedBox(height: 10),

              // Question and Options
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question
                        Container(decoration: BoxDecoration(color: AppColors.quizeQuetionscolor, borderRadius: BorderRadius.circular(13)), padding: EdgeInsets.symmetric(horizontal: media.width * 0.035, vertical: media.height * 0.012), child: Text("Q${currentIndex + 1}: ${q.question}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                        SizedBox(height: media.height * 0.016),

                        // Options
                        ...List.generate(q.options.length, (i) {
                          Color color;
                          if (i == q.correctIndex) {
                            color = Colors.green;
                          } else if (i == selectedIndex) {
                            color = Colors.red;
                          } else {
                            color = Colors.grey.shade200;
                          }
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: media.width * 0.015),
                              Padding(padding: const EdgeInsets.all(3.0), child: Container(width: media.width * 0.13, height: media.height * 0.06, decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: AppColors.quizebuttoncolorbluetypecolor, shape: BoxShape.rectangle), alignment: Alignment.center, child: Text(String.fromCharCode(65 + i), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                              Expanded(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  padding: const EdgeInsets.all(16),

                                  decoration: BoxDecoration(
                                    color: color, //
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  height: media.height * 0.085,
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [Text(" ${q.options[i]}", style: const TextStyle(fontSize: 15))]),
                                ),
                              ),
                            ],
                          );
                          return Container(margin: const EdgeInsets.symmetric(vertical: 4), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Text("${String.fromCharCode(65 + i)}. ${q.options[i]}", style: TextStyle(fontSize: 15)));
                        }),

                        const SizedBox(height: 10),
                        Text("Your answer: ${String.fromCharCode(65 + selectedIndex)}", style: TextStyle(color: isCorrect ? Colors.green : Colors.red, fontWeight: FontWeight.w600)),
                        // Container(
                        //   color: Colors.white,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Padding(padding: const EdgeInsets.all(16), child: Center(child: Column(children: [Text("Explanation", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)), Text(q.explanation, style: const TextStyle(fontSize: 14))]))),
                        //     ],
                        //   ),
                        // ),
                        if (q.explanation.isNotEmpty) Column(children: [const SizedBox(height: 8), Padding(padding: const EdgeInsets.all(8.0), child: Center(child: Text("Explanation:", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)))), const SizedBox(height: 4), Container(decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(15), color: Colors.white), child: Padding(padding: const EdgeInsets.all(8.0), child: Text(q.explanation, style: const TextStyle(color: Colors.black54, fontSize: 13))))]),
                      ],
                    ),
                  ),
                ),
              ),

              // Navigation Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: media.width * 0.028, vertical: media.height * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed:
                          currentIndex == 0
                              ? null
                              : () {
                                setState(() {
                                  currentIndex--;
                                });
                              },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor),
                      child: const Text("Previous", style: TextStyle(color: AppTextColors.appTextColorWhite)),
                    ),
                    ElevatedButton(
                      onPressed:
                          currentIndex == widget.questions.length - 1
                              ? null
                              : () {
                                setState(() {
                                  currentIndex++;
                                });
                              },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor),
                      child: Text("Next", style: TextStyle(color: AppTextColors.appTextColorWhite)),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 12),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ElevatedButton.icon(
              //         onPressed:
              //             currentIndex == 0
              //                 ? null
              //                 : () {
              //                   setState(() {
              //                     currentIndex--;
              //                   });
              //                 },
              //         icon: const Icon(Icons.arrow_back),
              //         label: const Text("Previous"),
              //         style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
              //       ),
              //       ElevatedButton.icon(
              //         onPressed:
              //             currentIndex == widget.questions.length - 1
              //                 ? null
              //                 : () {
              //                   setState(() {
              //                     currentIndex++;
              //                   });
              //                 },
              //         icon: const Icon(Icons.arrow_forward),
              //         label: const Text("Next"),
              //         style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class QuizReviewScreen extends StatelessWidget {
//   final List<QuestionModel> questions;
//   final List<int> selectedAnswers; // from state
//
//   const QuizReviewScreen({super.key, required this.questions, required this.selectedAnswers});
//
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBarWidget(appTitle: "Review Answers"),
//       body: ListView.builder(
//         itemCount: questions.length,
//         itemBuilder: (context, index) {
//           final q = questions[index];
//           final selectedIndex = selectedAnswers[index];
//           final isCorrect = selectedIndex == q.correctIndex;
//
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Container(width: media.width * 0.4, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.quizebuttoncolorbluetypecolor, borderRadius: BorderRadius.circular(13)), child: Text("Question No.", style: const TextStyle(color: Colors.white, fontSize: 16))), Container(alignment: Alignment.center, width: media.width * 0.4, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.quizebuttoncolorbluetypecolor, borderRadius: BorderRadius.circular(13)), child: Text("${index + 1} / ${questions.length}", style: const TextStyle(color: Colors.white, fontSize: 16)))]),
//
//                   Padding(padding: const EdgeInsets.all(5.0), child: Container(decoration: BoxDecoration(color: AppColors.quizeQuetionscolor, borderRadius: BorderRadius.circular(13)), child: Padding(padding: EdgeInsets.symmetric(horizontal: media.width * 0.035, vertical: media.height * 0.012), child: Text("Q${index + 1}: ${q.question}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600))))),
//                   Text("Q${index + 1}: ${q.question}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   ...List.generate(q.options.length, (i) {
//                     Color color;
//                     if (i == q.correctIndex) {
//                       color = Colors.green;
//                     } else if (i == selectedIndex) {
//                       color = Colors.red;
//                     } else {
//                       color = Colors.grey.shade200;
//                     }
//                     return Container(margin: const EdgeInsets.symmetric(vertical: 4), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text("${String.fromCharCode(65 + i)}. ${q.options[i]}"));
//                   }),
//                   const SizedBox(height: 8),
//                   Text("Your answer: ${String.fromCharCode(65 + selectedIndex)}", style: TextStyle(color: isCorrect ? Colors.green : Colors.red)),
//                   if (q.explanation.isNotEmpty) ...[const SizedBox(height: 6), Text("Explanation: ${q.explanation}", style: const TextStyle(color: Colors.black54, fontSize: 13))],
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
