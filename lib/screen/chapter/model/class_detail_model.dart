class ClassDetailResponse {
  final bool status;
  final String message;
  final ClassDetailData data;

  ClassDetailResponse({required this.status, required this.message, required this.data});

  factory ClassDetailResponse.fromJson(Map<String, dynamic> json) {
    return ClassDetailResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: ClassDetailData.fromJson(json['data'] ?? {}));
  }
}

class ClassDetailData {
  final String className;
  final List<Subject> subjects;

  ClassDetailData({required this.className, required this.subjects});

  factory ClassDetailData.fromJson(Map<String, dynamic> json) {
    return ClassDetailData(className: json['class_name'] ?? '', subjects: (json['subjects'] as List<dynamic>?)?.map((item) => Subject.fromJson(item)).toList() ?? []);
  }
}

class Subject {
  final int subjectId;
  final String subjectName;
  final List<Chapter> chapters;

  Subject({required this.subjectId, required this.subjectName, required this.chapters});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(subjectId: json['subject_id'] ?? 0, subjectName: json['subject_name'] ?? '', chapters: (json['chapters'] as List<dynamic>?)?.map((item) => Chapter.fromJson(item)).toList() ?? []);
  }
}

class Chapter {
  final int chapterId;
  final String chapterName;

  Chapter({required this.chapterId, required this.chapterName});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(chapterId: json['chapter_id'] ?? 0, chapterName: json['chapter_name'] ?? '');
  }
}
