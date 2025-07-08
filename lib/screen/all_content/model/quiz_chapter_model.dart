class QuizListResponse {
  final bool status;
  final String message;
  final List<QuizItem> data;

  QuizListResponse({required this.status, required this.message, required this.data});

  factory QuizListResponse.fromJson(Map<String, dynamic> json) {
    return QuizListResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>? ?? []).map((e) => QuizItem.fromJson(e)).toList());
  }
}

class QuizItem {
  final int quizId;
  final int chapterId;
  final String title;
  final int isPaid;
  final String createdAt;
  final String? updatedAt;

  QuizItem({required this.quizId, required this.chapterId, required this.title, required this.isPaid, required this.createdAt, this.updatedAt});

  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(quizId: json['quiz_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, title: json['title'] ?? '', isPaid: json['is_paid'] ?? 0, createdAt: json['created_at'] ?? '', updatedAt: json['updated_at']);
  }
}
