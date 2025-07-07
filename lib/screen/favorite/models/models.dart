// models/favorite_item.dart
class FavoriteItem {
  final String title;
  final String subtitle;
  final String thumbnailUrl;
  final String? videoUrlHindi;
  final String? videoUrlEnglish;
  final String videoType;
  final String isPaid;
  final String? isPurchase;
  final String type; // "Video", "Test", "Notes"

  FavoriteItem({required this.isPurchase, this.videoUrlHindi, this.videoUrlEnglish, required this.isPaid, required this.videoType, required this.title, required this.subtitle, required this.thumbnailUrl, required this.type});
}

class FavoriteVideoResponse {
  final bool status;
  final String message;
  final List<FavoriteVideo> data;

  FavoriteVideoResponse({required this.status, required this.message, required this.data});

  factory FavoriteVideoResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteVideoResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => FavoriteVideo.fromJson(e)).toList() ?? []);
  }
}

class FavoriteVideo {
  final int favoriteId;
  final int userId;
  final int videoId;
  final String createdAt;
  final String? updatedAt;
  final String videoTitle;
  final String? videoUrlHindi;
  final String? videoUrlEnglish;
  final int videoType;
  final String description;
  final int isPaid;
  final String thumbnailUrl;
  final String? duration;

  FavoriteVideo({required this.favoriteId, required this.userId, required this.videoId, required this.createdAt, this.updatedAt, required this.videoTitle, required this.videoUrlHindi, this.videoUrlEnglish, required this.videoType, required this.description, required this.isPaid, required this.thumbnailUrl, this.duration});

  factory FavoriteVideo.fromJson(Map<String, dynamic> json) {
    return FavoriteVideo(favoriteId: json['favorite_id_PK'] ?? 0, userId: json['user_id_FK'] ?? 0, videoId: json['video_id_FK'] ?? 0, createdAt: json['created_at'] ?? '', updatedAt: json['updated_at'], videoTitle: json['video_title'] ?? '', videoUrlHindi: json['video_url_hindi'] ?? '', videoUrlEnglish: json['video_url_english'], videoType: json['video_type'] ?? 0, description: json['description'] ?? '', isPaid: json['is_paid'] ?? 0, thumbnailUrl: json['thumbnail_url'] ?? '', duration: json['duration']);
  }
}
