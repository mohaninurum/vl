// class QuizResponse {
//   final bool status;
//   final String message;
//   final List<QuizData> data;
//
//   QuizResponse({required this.status, required this.message, required this.data});
//
//   factory QuizResponse.fromJson(Map<String, dynamic> json) {
//     return QuizResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((item) => QuizData.fromJson(item)).toList() ?? []);
//   }
// }
//
// class QuizData {
//   final int quizId;
//   final int chapterId;
//   final String questionText;
//   final String option1;
//   final String option2;
//   final String option3;
//   final String option4;
//   final int correctOption;
//   final String? explanation;
//
//   QuizData({required this.quizId, required this.chapterId, required this.questionText, required this.option1, required this.option2, required this.option3, required this.option4, required this.correctOption, this.explanation});
//
//   factory QuizData.fromJson(Map<String, dynamic> json) {
//     return QuizData(quizId: json['quiz_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, questionText: json['question_text'] ?? '', option1: json['option_1'] ?? '', option2: json['option_2'] ?? '', option3: json['option_3'] ?? '', option4: json['option_4'] ?? '', correctOption: json['correct_option'] ?? 0, explanation: json['explanation']);
//   }
// }
class QuizResponse {
  final bool status;
  final String message;
  final List<QuizQuestionModel> data;

  QuizResponse({required this.status, required this.message, required this.data});

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => QuizQuestionModel.fromJson(e)).toList() ?? []);
  }
}

class QuizQuestionModel {
  final int quizIdPk;
  final int quizIdFk;
  final int chapterIdFk;
  final int questionNo;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final int rightAnswer; // 1-based index
  final String explanation;

  QuizQuestionModel({required this.quizIdPk, required this.quizIdFk, required this.chapterIdFk, required this.questionNo, required this.question, required this.optionA, required this.optionB, required this.optionC, required this.optionD, required this.rightAnswer, required this.explanation});

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(quizIdPk: json['quiz_id_PK'] ?? 0, quizIdFk: json['quiz_id_FK'] ?? 0, chapterIdFk: json['chapter_id_FK'] ?? 0, questionNo: json['question_no'] ?? 0, question: json['question'] ?? '', optionA: json['option_a'] ?? '', optionB: json['option_b'] ?? '', optionC: json['option_c'] ?? '', optionD: json['option_d'] ?? '', rightAnswer: json['right_answer'] ?? 0, explanation: json['explanation'] ?? '');
  }

  List<String> get options => [optionA, optionB, optionC, optionD];

  int get correctIndex => rightAnswer - 1;
}
