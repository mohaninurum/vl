class FavoriteVideoListResponse {
  final bool status;
  final String message;
  final List<FavoriteVideoItem> data;

  FavoriteVideoListResponse({required this.status, required this.message, required this.data});

  factory FavoriteVideoListResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteVideoListResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((item) => FavoriteVideoItem.fromJson(item)).toList() ?? []);
  }
}

/////////////////////
class FavoriteVideoItem {
  final int favoriteId;
  final int userId;
  final int videoId;
  final int languageType;
  final String? createdAt;
  final String? updatedAt;
  final String videoTitle;
  final String videoUrlHindi;
  final String videoUrlEnglish;
  final int videoType;
  final String? description;
  final int isPaid;
  final String thumbnailUrl;
  final String? duration;
  final String chapterName;
  final String subjectName;
  final String className;

  FavoriteVideoItem({required this.favoriteId, required this.userId, required this.videoId, required this.languageType, this.createdAt, this.updatedAt, required this.videoTitle, required this.videoUrlHindi, required this.videoUrlEnglish, required this.videoType, this.description, required this.isPaid, required this.thumbnailUrl, this.duration, required this.chapterName, required this.subjectName, required this.className});

  factory FavoriteVideoItem.fromJson(Map<String, dynamic> json) {
    return FavoriteVideoItem(favoriteId: json['favorite_id_PK'] ?? 0, userId: json['user_id_FK'] ?? 0, videoId: json['video_id_FK'] ?? 0, languageType: json['language_type'] ?? 0, createdAt: json['created_at'], updatedAt: json['updated_at'], videoTitle: json['video_title'] ?? '', videoUrlHindi: json['video_url_hindi'] ?? '', videoUrlEnglish: json['video_url_english'] ?? '', videoType: json['video_type'] ?? 0, description: json['description'], isPaid: json['is_paid'] ?? 0, thumbnailUrl: json['thumbnail_url'] ?? '', duration: json['duration'], chapterName: json['chapter_name'] ?? '', subjectName: json['subject_name'] ?? '', className: json['class_name'] ?? '');
  }
}
