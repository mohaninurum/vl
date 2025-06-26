import '../../models/subject_model.dart';

abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class SelectClass extends NotesEvent {
  final String className;
  SelectClass(this.className);
}

class SelectSubjectEvent extends NotesEvent {
  final SubjectData selected;
  SelectSubjectEvent(this.selected);
}

class SelectSubject extends NotesEvent {
  final String subject;
  SelectSubject(this.subject);
}

// class GetSubject extends NotesEvent {
//   final context;
//   final String id;
//   final token;
//   GetSubject({required this.id, required this.token, this.context});
// }

class GetClasses extends NotesEvent {
  final context;
  final String id;
  final token;
  GetClasses({required this.id, required this.token, this.context});
}
