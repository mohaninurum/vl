abstract class NotesSubjectState {}

class IsinitialNotesSubject extends NotesSubjectState {}

class IsLoadigNotesSubject extends NotesSubjectState {}

class LoadedNotesSubject extends NotesSubjectState {
  List<String>? subjectsbloc;
  LoadedNotesSubject({this.subjectsbloc});
}

class FailNotesSubject extends NotesSubjectState {}
