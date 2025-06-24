//

import '../models/notes_model.dart';

class NotesState {
  bool isLoadingSubject;
  List<String> classes;
  List<String>? subject;
  final List<NoteModel> allNotes;
  final String selectedClass;
  final String selectedSubject;
  final List<NoteModel> filteredNotes;

  NotesState({required this.isLoadingSubject, required this.classes, this.subject, required this.allNotes, required this.selectedClass, required this.selectedSubject, required this.filteredNotes});

  NotesState copyWith({required bool isLoadingSubject, required List<String> classes, List<String>? subject, List<NoteModel>? allNotes, String? selectedClass, String? selectedSubject, List<NoteModel>? filteredNotes}) {
    return NotesState(isLoadingSubject: isLoadingSubject, allNotes: allNotes ?? this.allNotes, selectedClass: selectedClass ?? this.selectedClass, selectedSubject: selectedSubject ?? this.selectedSubject, filteredNotes: filteredNotes ?? this.filteredNotes, classes: []);
  }
}

class NotesLoading extends NotesState {
  NotesLoading() : super(allNotes: [], selectedClass: '9th', selectedSubject: 'Science', filteredNotes: [], classes: [], isLoadingSubject: true);
}
