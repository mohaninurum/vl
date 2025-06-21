class QuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  QuestionModel({required this.question, required this.options, required this.correctIndex, required this.explanation});
}
