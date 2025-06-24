class SubjectResponse {
  final bool status;
  final String message;
  final List<SubjectData> data;

  SubjectResponse({required this.status, required this.message, required this.data});

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((item) => SubjectData.fromJson(item)).toList() ?? []);
  }
}

class SubjectData {
  final int subjectId;
  final String subjectName;
  final int classId;
  final String className;

  SubjectData({required this.subjectId, required this.subjectName, required this.classId, required this.className});

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(subjectId: json['subject_id_PK'] ?? 0, subjectName: json['subject_name'] ?? '', classId: json['class_id_PK'] ?? 0, className: json['class_name'] ?? '');
  }
}
