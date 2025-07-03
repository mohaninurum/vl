import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/screen/quiz/quiz_screen/quiz_result.dart';

import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../widgets/appBarWidget.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';

class QuizScreen extends StatefulWidget {
  final selectClassesName;
  final selectChapterName;
  final language;
  final tabtype;
  final id;
  final isPreview;

  const QuizScreen({super.key, this.selectClassesName, this.selectChapterName, this.language, this.tabtype, this.id, this.isPreview});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Color getrightIconsOptionColor(QuizState state, int index) {
    if (state.isSelectAnswer) {
      if (!state.isSelectAnswer) return AppColors.quizeQuetionscolor;
      // if (index == state.currentQuestion.correctIndex) return Colors.green;
      if (index == state.selectedIndex) return Colors.orange;
      // return Colors.red;
    } else if (!state.isSelectAnswer) {
      // if (!state.showResult) return AppColors.quizeQuetionscolor;
      if (index == state.selectedIndex) {
        if (state.selectedIndex == state.currentQuestion.correctIndex) {
          return Colors.green;
        } else {
          return Colors.red;
        }
      }
    }
    return AppColors.quizeQuetionscolor;
  }

  Color getOptionColor(QuizState state, int index) {
    if (state.isSelectAnswer) {
      if (!state.isSelectAnswer) return AppColors.quizeQuetionscolor;
      // if (index == state.currentQuestion.correctIndex) return Colors.green;
      if (index == state.selectedIndex) return Colors.orange;
      // return Colors.red;
    } else if (widget.isPreview) {
      if (index == state.currentQuestion.correctIndex) {
        return Colors.green;
      } else if (index == state.selectedIndex) {
        return Colors.red;
      } else {
        return AppColors.quizeQuetionscolor;
      }
    }
    // else if (!state.isSelectAnswer) {
    //   // if (!state.showResult) return AppColors.quizeQuetionscolor;
    //   if (index == state.selectedIndex) {
    //     if (state.selectedIndex == state.currentQuestion.correctIndex) {
    //       return Colors.green;
    //     } else {
    //       return Colors.red;
    //     }
    //   }
    // }
    return AppColors.quizeQuetionscolor;
  }

  @override
  void initState() {
    super.initState();
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    // context.read<TestPaperContentBloc>().add(LoadTestPaperContent(id: widget.id, context: context, token: token));
    context.read<QuizBloc>().add(IsLoadingQuiz(token: token, context: context, id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    // var indexget = widget.selectClassesName.indexOf('h');
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(appTitle: '${widget.selectClassesName} ${widget.tabtype}'),
        backgroundColor: Colors.white,
        body: BlocListener<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state.isLoading) {
              setState(() {});
            }
          },
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              return state.isLoading
                  ? state.questions.isNotEmpty
                      ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: media.width * 0.02, vertical: media.height * 0.01),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                                padding: EdgeInsets.all(media.width * 0.04),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [Text("Class:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectClassesName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                                          // Row(children: [Text("Language:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(language, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                                          Row(children: [Text("Chapter:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectChapterName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: media.width * 0.015),
                                    Image.asset('assets/appicons/icon5Asset 5.png', height: media.height * 0.12),
                                  ],
                                ),
                              ),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Container(width: media.width * 0.4, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.quizebuttoncolorbluetypecolor, borderRadius: BorderRadius.circular(13)), child: Text("Question No.", style: const TextStyle(color: Colors.white, fontSize: 16))), Container(alignment: Alignment.center, width: media.width * 0.4, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.quizebuttoncolorbluetypecolor, borderRadius: BorderRadius.circular(13)), child: Text("${state.currentIndex + 1} / ${state.questions.length}", style: const TextStyle(color: Colors.white, fontSize: 16)))]),

                            SizedBox(height: media.height * 0.02),
                            Padding(padding: const EdgeInsets.all(5.0), child: Container(decoration: BoxDecoration(color: AppColors.quizeQuetionscolor, borderRadius: BorderRadius.circular(13)), child: Padding(padding: EdgeInsets.symmetric(horizontal: media.width * 0.035, vertical: media.height * 0.012), child: Text(state.currentQuestion.question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))))),
                            SizedBox(height: media.height * 0.015),
                            ...List.generate(state.currentQuestion.options.length, (index) {
                              // print(state.currentQuestion.question[index]);
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: media.width * 0.015),
                                  Padding(padding: const EdgeInsets.all(3.0), child: Container(width: media.width * 0.13, height: media.height * 0.06, decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: AppColors.quizebuttoncolorbluetypecolor, shape: BoxShape.rectangle), alignment: Alignment.center, child: Text(String.fromCharCode(65 + index), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => context.read<QuizBloc>().add(SelectAnswer(index)),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                        padding: const EdgeInsets.all(16),

                                        decoration: BoxDecoration(
                                          color: getOptionColor(state, index), //
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Colors.grey.shade300),
                                        ),
                                        height: media.height * 0.085,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if (state.showResult && index == state.currentQuestion.correctIndex) SizedBox(width: media.width * 0.0),
                                            // Expanded(child: SizedBox(width: media.width * 0.3)),
                                            Text(state.currentQuestion.options[index], style: const TextStyle(fontSize: 15)),
                                            // Spacer(),
                                            // !state.isSelectAnswer && state.showResult && index == state.selectedIndex && index == state.currentQuestion.correctIndex
                                            //     ? const Icon(Icons.check, color: Colors.white)
                                            //     : getOptionColor(state, index) == Colors.red
                                            //     ? Icon(Icons.close, color: Colors.white)
                                            //     : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            // if (!state.showResult && state.selectedIndex != -1)
                            if (!state.isSelectAnswer && state.showResult && state.selectedIndex == state.selectedIndex && state.selectedIndex == state.currentQuestion.correctIndex) ...[
                              ElevatedButton(onPressed: () => context.read<QuizBloc>().add(ShowExplanationAnswer(isSelectAnswer: state.isSelectAnswer, selectedIndex: state.selectedIndex, showExplanation: state.showExplanation, showResult: state.showResult)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.quizebuttoncolorbluetypecolor), child: Text(state.showExplanation ? "Hide Explanation" : "Show Explanation", style: TextStyle(color: AppTextColors.appTextColorWhite))),
                              state.showExplanation
                                  ? Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(padding: const EdgeInsets.all(16), child: Center(child: Column(children: [Text("Explanation", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)), Text(state.currentQuestion.explanation, style: const TextStyle(fontSize: 14))]))),
                                      ],
                                    ),
                                  )
                                  : SizedBox.shrink(),
                            ],

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: media.width * 0.028, vertical: media.height * 0.015),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(onPressed: state.isFirst ? null : () => context.read<QuizBloc>().add(PreviousQuestion()), style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor), child: const Text("Previous", style: TextStyle(color: AppTextColors.appTextColorWhite))),
                                  // ElevatedButton(onPressed: () => context.read<QuizBloc>().add(CheckAnswer()), style: ElevatedButton.styleFrom(backgroundColor: AppColors.checkButtonscolor), child: const Text("Check", style: TextStyle(color: AppTextColors.appTextColorWhite))),
                                  "${state.currentIndex + 1}" == "${state.questions.length}" && state.selectedAnswers.isNotEmpty
                                      ? ElevatedButton(
                                        onPressed: () {
                                          final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => QuizResultScreen(questions: state.questions, selectedAnswers: state.selectedAnswers))).then((value) {
                                            context.read<QuizBloc>().add(IsLoadingQuiz(token: token, context: context, id: widget.id));
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor),
                                        child: const Text("Result Overview", style: TextStyle(color: AppTextColors.appTextColorWhite)),
                                      )
                                      : SizedBox.shrink(),
                                  ElevatedButton(onPressed: state.isLast ? null : () => context.read<QuizBloc>().add(NextQuestion()), style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor), child: const Text("Next", style: TextStyle(color: AppTextColors.appTextColorWhite))),
                                ],
                              ),
                            ),

                            //    state.isLast
                            //  ?
                            Container(color: Colors.black87, width: media.height * 0.1),
                          ],
                        ),
                      )
                      : Column(mainAxisAlignment: MainAxisAlignment.center, children: [Center(child: Text("No Record"))])
                  : Column(mainAxisAlignment: MainAxisAlignment.center, children: [Center(child: CupertinoActivityIndicator(radius: 20))]);
            },
          ),
        ),
      ),
    );
  }
}
