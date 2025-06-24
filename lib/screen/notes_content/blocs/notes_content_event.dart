abstract class NotesContentEvent {}

class LoadNotesContent extends NotesContentEvent {
  final context;
  final token;
  String id;
  LoadNotesContent({this.token, this.context, required this.id});
}
