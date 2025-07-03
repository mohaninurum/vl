import 'dart:ui';

class ChapterContentModel {
  final String? imageUrl;
  final String? VideoUrl;
  final String? title;
  final String subtitle;
  final String gradeLangEn;
  final String gradeLangHi;
  final Color bgColor;
  final String? isPaid;
  final String? isPurchase;
  final String? videoType;

  ChapterContentModel({this.videoType, this.isPurchase, this.isPaid, required this.VideoUrl, required this.imageUrl, required this.title, required this.subtitle, required this.gradeLangEn, required this.gradeLangHi, required this.bgColor});
}

class VideoListResponse {
  final bool status;
  final String message;
  final List<VideoData> data;

  VideoListResponse({required this.status, required this.message, required this.data});

  factory VideoListResponse.fromJson(Map<String, dynamic> json) {
    return VideoListResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => VideoData.fromJson(e)).toList() ?? []);
  }
}

class VideoData {
  final int? videoId;
  final int? chapterId;
  final String? videoTitle;
  final String? videoUrl;
  final int? videoType;
  final String? description;
  final String? isPaid;
  final String? isPurchase;
  final String? thumbnailUrl;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;

  VideoData({this.videoId, this.chapterId, this.videoTitle, this.videoUrl, this.videoType, this.description, this.isPaid, this.isPurchase, this.thumbnailUrl, this.duration, this.createdAt, this.updatedAt});

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(videoId: json['video_id_PK'] as int?, chapterId: json['chapter_id_FK'] as int?, videoTitle: json['video_title'] as String?, videoUrl: json['video_url'] as String?, videoType: json['video_type'] as int?, description: json['description'] as String?, isPaid: json['is_paid']?.toString(), isPurchase: json['is_purchase']?.toString(), thumbnailUrl: json['thumbnail_url'] as String?, duration: json['duration'] as String?, createdAt: json['created_at'] as String?, updatedAt: json['updated_at'] as String?);
  }
}
