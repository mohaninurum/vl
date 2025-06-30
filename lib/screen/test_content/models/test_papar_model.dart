class TestPaperResponse {
  final bool status;
  final String message;
  final List<TestPaper> data;

  TestPaperResponse({required this.status, required this.message, required this.data});

  factory TestPaperResponse.fromJson(Map<String, dynamic> json) {
    return TestPaperResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => TestPaper.fromJson(e)).toList() ?? []);
  }
}

class TestPaper {
  final int testpaperId;
  final int chapterId;
  final String pdfTitle;
  final String pdfUrl;
  final int isPaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TestPaper({required this.testpaperId, required this.chapterId, required this.pdfTitle, required this.pdfUrl, required this.isPaid, this.createdAt, this.updatedAt});

  factory TestPaper.fromJson(Map<String, dynamic> json) {
    return TestPaper(testpaperId: json['testpaper_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, pdfTitle: json['pdf_title'] ?? '', pdfUrl: json['pdf_url'] ?? '', isPaid: json['is_paid'] ?? 0, createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null, updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null);
  }
}
