class QuizResponse {
  final bool status;
  final String message;
  final List<QuizData> data;

  QuizResponse({required this.status, required this.message, required this.data});

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((item) => QuizData.fromJson(item)).toList() ?? []);
  }
}

class QuizData {
  final int quizId;
  final int chapterId;
  final String questionText;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int correctOption;
  final String? explanation;

  QuizData({required this.quizId, required this.chapterId, required this.questionText, required this.option1, required this.option2, required this.option3, required this.option4, required this.correctOption, this.explanation});

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(quizId: json['quiz_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, questionText: json['question_text'] ?? '', option1: json['option_1'] ?? '', option2: json['option_2'] ?? '', option3: json['option_3'] ?? '', option4: json['option_4'] ?? '', correctOption: json['correct_option'] ?? 0, explanation: json['explanation']);
  }
}
