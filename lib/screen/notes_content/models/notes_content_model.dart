class NotesPdfResponse {
  final bool status;
  final String message;
  final List<NotePdf> data;

  NotesPdfResponse({required this.status, required this.message, required this.data});

  factory NotesPdfResponse.fromJson(Map<String, dynamic> json) {
    return NotesPdfResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: (json['data'] as List<dynamic>?)?.map((e) => NotePdf.fromJson(e)).toList() ?? []);
  }
}

class NotePdf {
  final int noteId;
  final int chapterId;
  final String pdfTitle;
  final String pdfUrl;
  final int isPaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotePdf({required this.noteId, required this.chapterId, required this.pdfTitle, required this.pdfUrl, required this.isPaid, this.createdAt, this.updatedAt});

  factory NotePdf.fromJson(Map<String, dynamic> json) {
    return NotePdf(noteId: json['note_id_PK'] ?? 0, chapterId: json['chapter_id_FK'] ?? 0, pdfTitle: json['pdf_title'] ?? '', pdfUrl: json['pdf_url'] ?? '', isPaid: json['is_paid'] ?? 0, createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null, updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null);
  }
}
