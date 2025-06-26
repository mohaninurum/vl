abstract class GetNotesListEvent {}

class GetNotesList extends GetNotesListEvent {
  final context;
  final String id;
  final token;
  final selectSubject;
  GetNotesList({required this.id, required this.token, this.context, this.selectSubject});
}
