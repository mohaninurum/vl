import 'dart:ui';

// class ChapterContentModel {
//   final String imageUrl;
//   final String title;
//   final String subtitle;
//   final String gradeLang;
//   Color bgColor;
//
//   ChapterContentModel({required this.imageUrl, required this.title, required this.subtitle, required this.gradeLang, required this.bgColor});
// }
class ChapterContentModel {
  final String imageUrl;
  final String VideoUrl;
  final String title;
  final String subtitle;
  final String gradeLangEn;
  final String gradeLangHi;
  final Color bgColor;

  ChapterContentModel({required this.VideoUrl, required this.imageUrl, required this.title, required this.subtitle, required this.gradeLangEn, required this.gradeLangHi, required this.bgColor});
}

class VideoListResponse {
  final bool status;
  final String message;
  final List<VideoData> data;

  VideoListResponse({required this.status, required this.message, required this.data});

  factory VideoListResponse.fromJson(Map<String, dynamic> json) {
    return VideoListResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((item) => VideoData.fromJson(item)).toList() ?? []);
  }
}

class VideoData {
  final int videoIdPk;
  final int chapterIdFk;
  final String videoTitle;
  final String videoUrl;
  final String? description;
  final String thumbnailUrl;
  final String? duration;
  final String createdAt;
  final String? updatedAt;

  VideoData({required this.videoIdPk, required this.chapterIdFk, required this.videoTitle, required this.videoUrl, this.description, required this.thumbnailUrl, this.duration, required this.createdAt, this.updatedAt});

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(videoIdPk: json['video_id_PK'] ?? 0, chapterIdFk: json['chapter_id_FK'] ?? 0, videoTitle: json['video_title'] ?? '', videoUrl: json['video_url'] ?? '', description: json['description'], thumbnailUrl: json['thumbnail_url'] ?? '', duration: json['duration'], createdAt: json['created_at'] ?? '', updatedAt: json['updated_at']);
  }
}
