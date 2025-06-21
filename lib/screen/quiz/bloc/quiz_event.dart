// -------------------- Events --------------------
abstract class QuizEvent {}

class SelectAnswer extends QuizEvent {
  final int index;
  SelectAnswer(this.index);
}

class IsLoadingQuiz extends QuizEvent {}

class SuccessQuiz extends QuizEvent {}

class CheckAnswer extends QuizEvent {}

class ShowExplanationAnswer extends QuizEvent {
  bool showExplanation;
  final int selectedIndex;
  final bool showResult;
  final bool isSelectAnswer;
  ShowExplanationAnswer({required this.showExplanation, required this.selectedIndex, required this.showResult, required this.isSelectAnswer});
}

class ResetAnswer extends QuizEvent {}

class NextQuestion extends QuizEvent {}

class PreviousQuestion extends QuizEvent {}
