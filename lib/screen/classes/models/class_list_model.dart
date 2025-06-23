class ClassListResponse {
  final bool status;
  final String message;
  final List<ClassItem> data;

  ClassListResponse({required this.status, required this.message, required this.data});

  factory ClassListResponse.fromJson(Map<String, dynamic> json) {
    return ClassListResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((item) => ClassItem.fromJson(item)).toList() ?? []);
  }
}

class ClassItem {
  final int classId;
  final String className;
  final String classIcon;
  final int categoryId;
  final String createdAt;
  final String? updatedAt;

  ClassItem({required this.classId, required this.className, required this.classIcon, required this.categoryId, required this.createdAt, this.updatedAt});

  factory ClassItem.fromJson(Map<String, dynamic> json) {
    return ClassItem(classId: json['class_id_PK'] ?? 0, className: json['class_name'] ?? '', classIcon: json['class_icon'] ?? '', categoryId: json['category_id_FK'] ?? 0, createdAt: json['created_at'] ?? '', updatedAt: json['updated_at']);
  }
}
