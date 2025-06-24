class TestPaperResponse {
  final bool status;
  final String message;
  final List<TestPaperData> data;

  TestPaperResponse({required this.status, required this.message, required this.data});

  factory TestPaperResponse.fromJson(Map<String, dynamic> json) {
    return TestPaperResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => TestPaperData.fromJson(e)).toList() ?? []);
  }
}

class TestPaperData {
  final int testpaperId;
  final int chapterId;
  final String pdfTitle;
  final String pdfUrl;
  final String createdAt;
  final String? updatedAt;

  TestPaperData({required this.testpaperId, required this.chapterId, required this.pdfTitle, required this.pdfUrl, required this.createdAt, this.updatedAt});

  factory TestPaperData.fromJson(Map<String, dynamic> json) {
    return TestPaperData(
      testpaperId: json['testpaper_id_PK'] ?? 0,
      chapterId: json['chapter_id_FK'] ?? 0,
      pdfTitle: json['pdf_title'] ?? '',
      pdfUrl: json['pdf_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'], // nullable field
    );
  }
}
