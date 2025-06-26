//

// class NotesState {
//   bool isLoadingSubject;
//   List<String> classes;
//   List<String>? subject;
//   final List<NoteModel> allNotes;
//   final String selectedClass;
//   final String selectedSubject;
//   final List<NoteModel> filteredNotes;
//   final bool? isLoading;
//
//   NotesState({this.isLoading, required this.isLoadingSubject, required this.classes, this.subject, required this.allNotes, required this.selectedClass, required this.selectedSubject, required this.filteredNotes});
//
//   NotesState copyWith({bool? isLoading, required bool isLoadingSubject, required List<String> classes, List<String>? subject, List<NoteModel>? allNotes, String? selectedClass, String? selectedSubject, List<NoteModel>? filteredNotes}) {
//     return NotesState(isLoading: isLoading, isLoadingSubject: isLoadingSubject, allNotes: allNotes ?? this.allNotes, selectedClass: selectedClass ?? this.selectedClass, selectedSubject: selectedSubject ?? this.selectedSubject, filteredNotes: filteredNotes ?? this.filteredNotes, classes: []);
//   }
// }
//
// class NotesLoading extends NotesState {
//   NotesLoading() : super(allNotes: [], selectedClass: '9th', selectedSubject: 'Science', filteredNotes: [], classes: [], isLoadingSubject: true);
// }

abstract class NotesState {}

class IsinitialsubjectNotes extends NotesState {}

class IsLoadigsubjectNotes extends NotesState {}

class LoadedSubjectNotes extends NotesState {
  List<String>? subjectsbloc;
  LoadedSubjectNotes({this.subjectsbloc});
}

class FailNotes extends NotesState {}

class IsinitialNotesClass extends NotesState {}

class IsLoadigNotesClass extends NotesState {}

class LoadedNotesClass extends NotesState {
  List<String>? Classbloc;
  LoadedNotesClass({this.Classbloc});
}

class FailNotesClass extends NotesState {}
