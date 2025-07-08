class SearchResponse {
  final bool status;
  final String message;
  final SearchData? data;

  SearchResponse({required this.status, required this.message, this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: json['data'] != null ? SearchData.fromJson(json['data']) : null);
  }
}

class SearchData {
  final List<VideoItem> videoList;
  final List<NoteItem> notesList;
  final List<TestPaperItem> testPaperList;
  final List<QuizItem> quiList;

  SearchData({required this.videoList, required this.notesList, required this.testPaperList, required this.quiList});

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(videoList: (json['VideoList'] as List<dynamic>? ?? []).map((e) => VideoItem.fromJson(e)).toList(), notesList: (json['notesList'] as List<dynamic>? ?? []).map((e) => NoteItem.fromJson(e)).toList(), testPaperList: (json['testPaperList'] as List<dynamic>? ?? []).map((e) => TestPaperItem.fromJson(e)).toList(), quiList: (json['quiList'] as List<dynamic>? ?? []).map((e) => QuizItem.fromJson(e)).toList());
  }
}

class VideoItem {
  final int videoId;
  final int chapterId;
  final String title;
  final String videoUrlHindi;
  final String videoUrlEnglish;
  final int videoType;
  final String description;
  final int isPaid;
  final bool? isPurchased;
  final String thumbnailUrl;
  final String? duration;
  final String createdAt;
  final String? updatedAt;

  VideoItem({required this.videoId, required this.chapterId, required this.title, required this.videoUrlHindi, required this.videoUrlEnglish, required this.videoType, required this.description, required this.isPaid, this.isPurchased, required this.thumbnailUrl, this.duration, required this.createdAt, this.updatedAt});

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(videoId: json['video_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, title: json['video_title'] ?? '', videoUrlHindi: json['video_url_hindi'] ?? '', videoUrlEnglish: json['video_url_english'] ?? '', videoType: json['video_type'] ?? 0, description: json['description'] ?? '', isPaid: json['is_paid'] ?? 0, isPurchased: json['is_purchase'] != null ? json['is_purchase'] == 1 : null, thumbnailUrl: json['thumbnail_url'] ?? '', duration: json['duration'], createdAt: json['created_at'] ?? '', updatedAt: json['updated_at']);
  }
}

class NoteItem {
  final int noteId;
  final int chapterId;
  final String title;
  final String pdfUrl;
  final int isPaid;
  final String createdAt;
  final String? updatedAt;

  NoteItem({required this.noteId, required this.chapterId, required this.title, required this.pdfUrl, required this.isPaid, required this.createdAt, this.updatedAt});

  factory NoteItem.fromJson(Map<String, dynamic> json) {
    return NoteItem(noteId: json['note_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, title: json['pdf_title'] ?? '', pdfUrl: json['pdf_url'] ?? '', isPaid: json['is_paid'] ?? 0, createdAt: json['created_at'] ?? '', updatedAt: json['updated_at']);
  }
}

class TestPaperItem {
  final int id;
  final int chapterId;
  final String title;
  final String pdfUrl;
  final int isPaid;
  final String createdAt;
  final String? updatedAt;

  TestPaperItem({required this.id, required this.chapterId, required this.title, required this.pdfUrl, required this.isPaid, required this.createdAt, this.updatedAt});

  factory TestPaperItem.fromJson(Map<String, dynamic> json) {
    return TestPaperItem(id: json['testpaper_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, title: json['pdf_title'] ?? '', pdfUrl: json['pdf_url'] ?? '', isPaid: json['is_paid'] ?? 0, createdAt: json['created_at'] ?? '', updatedAt: json['updated_at']);
  }
}

class QuizItem {
  final int id;
  final int chapterId;
  final String title;
  final int isPaid;
  final String createdAt;
  final String? updatedAt;

  QuizItem({required this.id, required this.chapterId, required this.title, required this.isPaid, required this.createdAt, this.updatedAt});

  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(id: json['quiz_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, title: json['title'] ?? '', isPaid: json['is_paid'] ?? 0, createdAt: json['created_at'] ?? '', updatedAt: json['updated_at']);
  }
}
