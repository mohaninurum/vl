class NotesPdfResponse {
  final bool status;
  final String message;
  final List<NotesPdfData> data;

  NotesPdfResponse({required this.status, required this.message, required this.data});

  factory NotesPdfResponse.fromJson(Map<String, dynamic> json) {
    return NotesPdfResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => NotesPdfData.fromJson(e)).toList() ?? []);
  }
}

class NotesPdfData {
  final int noteId;
  final int chapterId;
  final String pdfTitle;
  final String pdfUrl;
  final String createdAt;
  final String? updatedAt;

  NotesPdfData({required this.noteId, required this.chapterId, required this.pdfTitle, required this.pdfUrl, required this.createdAt, this.updatedAt});

  factory NotesPdfData.fromJson(Map<String, dynamic> json) {
    return NotesPdfData(
      noteId: json['note_id_PK'] ?? 0,
      chapterId: json['chapter_id_FK'] ?? 0,
      pdfTitle: json['pdf_title'] ?? '',
      pdfUrl: json['pdf_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'], // nullable field
    );
  }
}
