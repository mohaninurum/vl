import 'dart:ui';

class VideoListResponse {
  final bool status;
  final String message;
  final List<VideoModel> data;

  VideoListResponse({required this.status, required this.message, required this.data});

  factory VideoListResponse.fromJson(Map<String, dynamic> json) {
    return VideoListResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => VideoModel.fromJson(e)).toList() ?? []);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class VideoModel {
  final int? videoIdPk;
  final int? chapterIdFk;
  final String? videoTitle;
  final String? videoUrlHindi;
  final String? videoUrlEnglish;
  final int? videoType;
  final String? description;
  final int? isPaid;
  final int? isPurchase;
  final String? thumbnailUrl;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;
  final int? isFavourite;

  VideoModel({this.videoIdPk, this.chapterIdFk, this.videoTitle, this.videoUrlHindi, this.videoUrlEnglish, this.videoType, this.description, this.isPaid, this.isPurchase, this.thumbnailUrl, this.duration, this.createdAt, this.updatedAt, this.isFavourite});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(videoIdPk: json['video_id_PK'], chapterIdFk: json['chapter_id_FK'], videoTitle: json['video_title'], videoUrlHindi: json['video_url_hindi'], videoUrlEnglish: json['video_url_english'], videoType: json['video_type'], description: json['description'], isPaid: json['is_paid'], isPurchase: json['is_purchase'], thumbnailUrl: json['thumbnail_url'], duration: json['duration'], createdAt: json['created_at'], updatedAt: json['updated_at'], isFavourite: json['is_favourite']);
  }

  Map<String, dynamic> toJson() {
    return {'video_id_PK': videoIdPk, 'chapter_id_FK': chapterIdFk, 'video_title': videoTitle, 'video_url_hindi': videoUrlHindi, 'video_url_english': videoUrlEnglish, 'video_type': videoType, 'description': description, 'is_paid': isPaid, 'is_purchase': isPurchase, 'thumbnail_url': thumbnailUrl, 'duration': duration, 'created_at': createdAt, 'updated_at': updatedAt, 'is_favourite': isFavourite};
  }
}

class ChapterContentModel {
  final String? imageUrl;
  final String? videoUrlHindi;
  final String? videoUrlEnglish;
  final String? title;
  final String subtitle;
  final String gradeLangEn;
  final String gradeLangHi;
  final Color bgColor;
  final String? isPaid;
  final String? isPurchase;
  final String? videoType;
  final String videoId;
  final bool? isFavorited;

  ChapterContentModel({this.isFavorited, required this.videoId, this.videoUrlHindi, this.videoUrlEnglish, this.videoType, this.isPurchase, this.isPaid, required this.imageUrl, required this.title, required this.subtitle, required this.gradeLangEn, required this.gradeLangHi, required this.bgColor});

  // ✅ Add this to fix your error
  ChapterContentModel copyWith({String? imageUrl, String? videoUrlHindi, String? videoUrlEnglish, String? title, String? subtitle, String? gradeLangEn, String? gradeLangHi, Color? bgColor, String? isPaid, String? isPurchase, String? videoType, String? videoId, bool? isFavorited}) {
    return ChapterContentModel(imageUrl: imageUrl ?? this.imageUrl, videoUrlHindi: videoUrlHindi ?? this.videoUrlHindi, videoUrlEnglish: videoUrlEnglish ?? this.videoUrlEnglish, title: title ?? this.title, subtitle: subtitle ?? this.subtitle, gradeLangEn: gradeLangEn ?? this.gradeLangEn, gradeLangHi: gradeLangHi ?? this.gradeLangHi, bgColor: bgColor ?? this.bgColor, isPaid: isPaid ?? this.isPaid, isPurchase: isPurchase ?? this.isPurchase, videoType: videoType ?? this.videoType, videoId: videoId ?? this.videoId, isFavorited: isFavorited ?? this.isFavorited);
  }
}

// class ChapterContentModel {
//   final String? imageUrl;
//   final String? videoUrlHindi;
//   final String? videoUrlEnglish;
//   final String? title;
//   final String subtitle;
//   final String gradeLangEn;
//   final String gradeLangHi;
//   final Color bgColor;
//   final String? isPaid;
//   final String? isPurchase;
//   final String? videoType;
//   final String videoId;
//   final bool? isFavorited;
//
//   ChapterContentModel({this.isFavorited, required this.videoId, this.videoUrlHindi, this.videoUrlEnglish, this.videoType, this.isPurchase, this.isPaid, required this.imageUrl, required this.title, required this.subtitle, required this.gradeLangEn, required this.gradeLangHi, required this.bgColor});
// }

//
// class VideoListResponse {
//   final bool status;
//   final String message;
//   final List<VideoData> data;
//
//   VideoListResponse({required this.status, required this.message, required this.data});
//
//   factory VideoListResponse.fromJson(Map<String, dynamic> json) {
//     return VideoListResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => VideoData.fromJson(e)).toList() ?? []);
//   }
// }
//
// class VideoData {
//   final int? videoId;
//   final int? chapterId;
//   final String? videoTitle;
//   final String? videoUrl;
//   final int? videoType;
//   final String? description;
//   final String? isPaid;
//   final String? isPurchase;
//   final String? thumbnailUrl;
//   final String? duration;
//   final String? createdAt;
//   final String? updatedAt;
//
//   VideoData({this.videoId, this.chapterId, this.videoTitle, this.videoUrl, this.videoType, this.description, this.isPaid, this.isPurchase, this.thumbnailUrl, this.duration, this.createdAt, this.updatedAt});
//
//   factory VideoData.fromJson(Map<String, dynamic> json) {
//     return VideoData(videoId: json['video_id_PK'] as int?, chapterId: json['chapter_id_FK'] as int?, videoTitle: json['video_title'] as String?, videoUrl: json['video_url'] as String?, videoType: json['video_type'] as int?, description: json['description'] as String?, isPaid: json['is_paid']?.toString(), isPurchase: json['is_purchase']?.toString(), thumbnailUrl: json['thumbnail_url'] as String?, duration: json['duration'] as String?, createdAt: json['created_at'] as String?, updatedAt: json['updated_at'] as String?);
//   }
// }
