class FeedbackResponse {
  final bool status;
  final String message;
  final List<FeedbackModel> data;

  FeedbackResponse({required this.status, required this.message, required this.data});

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    return FeedbackResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((item) => FeedbackModel.fromJson(item)).toList() ?? []);
  }
}

class FeedbackModel {
  final int id;
  final String fullName;
  final String feedback;
  final DateTime createdAt;

  FeedbackModel({required this.id, required this.fullName, required this.feedback, required this.createdAt});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(id: json['feedback_id_PK'] ?? 0, fullName: json['full_name'] ?? '', feedback: json['feedback'] ?? '', createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now());
  }
}
