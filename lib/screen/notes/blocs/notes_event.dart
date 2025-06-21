abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class SelectClass extends NotesEvent {
  final String className;
  SelectClass(this.className);
}

class SelectSubject extends NotesEvent {
  final String subject;
  SelectSubject(this.subject);
}
