abstract class QuizEvent {}

class LoadedChapterQuiz extends QuizEvent {
  final id;
  final context;
  final token;
  LoadedChapterQuiz({this.id, this.context, this.token});
}
