class NotificationResponse {
  final bool status;
  final String message;
  final List<NotificationItem> data;

  NotificationResponse({required this.status, required this.message, required this.data});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => NotificationItem.fromJson(e)).toList() ?? []);
  }
}

class NotificationItem {
  final int notificationId;
  final String title;
  final String description;
  final int? contentId;
  final String contentType;
  final String createdAt;

  // Optional fields
  final String? contentUrl;
  final String? quizTitle;
  final int? quizId;
  final String? videoUrlHindi;
  final String? videoUrlEnglish;
  final String? thumbnailUrl;
  final int? videoType;

  NotificationItem({required this.notificationId, required this.title, required this.description, required this.contentId, required this.contentType, required this.createdAt, this.contentUrl, this.quizTitle, this.quizId, this.videoUrlHindi, this.videoUrlEnglish, this.thumbnailUrl, this.videoType});

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(notificationId: json['notification_id_PK'] ?? 0, title: json['title'] ?? '', description: json['description'] ?? '', contentId: json['content_id'], contentType: json['content_type'] ?? '', createdAt: json['created_at'] ?? '', contentUrl: json['content_url'], quizTitle: json['quiz_title'], quizId: json['quiz_id'], videoUrlHindi: json['video_url_hindi'], videoUrlEnglish: json['video_url_english'], thumbnailUrl: json['thumbnail_url'], videoType: json['video_type']);
  }
}
