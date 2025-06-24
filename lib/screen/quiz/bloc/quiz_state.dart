// --- State ---
import '../models/question_model.dart';

// class QuizState {
//   final List<QuestionModel> questions;
//   final int currentIndex;
//   final int selectedIndex;
//   final bool isAnswered;
//
//   QuizState({required this.questions, this.currentIndex = 0, this.selectedIndex = -1, this.isAnswered = false});
//
//   QuestionModel get currentQuestion => questions[currentIndex];
//
//   bool get isLast => currentIndex == questions.length - 1;
//   bool get isFirst => currentIndex == 0;
//
//   QuizState copyWith({int? currentIndex, int? selectedIndex, bool? isAnswered}) {
//     return QuizState(questions: questions, currentIndex: currentIndex ?? this.currentIndex, selectedIndex: selectedIndex ?? this.selectedIndex, isAnswered: isAnswered ?? this.isAnswered);
//   }
// }
class QuizState {
  final List<QuestionModel> questions;
  final int currentIndex;
  final int selectedIndex;
  final bool showResult;
  final bool showExplanation;
  final bool isSelectAnswer;
  final bool isLoading;

  QuizState({required this.isLoading, required this.isSelectAnswer, required this.showExplanation, required this.questions, required this.currentIndex, required this.selectedIndex, required this.showResult});

  factory QuizState.initial() {
    return QuizState(questions: [], currentIndex: 0, selectedIndex: -1, showResult: false, showExplanation: false, isSelectAnswer: false, isLoading: false);
  }

  QuizState copyWith({bool? isLoading, bool? isSelectAnswer, bool? showExplanation, List<QuestionModel>? questions, int? currentIndex, int? selectedIndex, bool? showResult}) {
    return QuizState(isLoading: isLoading ?? this.isLoading, isSelectAnswer: isSelectAnswer ?? this.isSelectAnswer, showExplanation: showExplanation ?? this.showExplanation, questions: questions ?? this.questions, currentIndex: currentIndex ?? this.currentIndex, selectedIndex: selectedIndex ?? this.selectedIndex, showResult: showResult ?? this.showResult);
  }

  QuestionModel get currentQuestion => questions[currentIndex];
  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == questions.length - 1;
}
