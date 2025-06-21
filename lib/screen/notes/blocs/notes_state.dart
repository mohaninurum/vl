import '../models/notes_model.dart';

class NotesState {
  final List<NoteModel> allNotes;
  final String selectedClass;
  final String selectedSubject;
  final List<NoteModel> filteredNotes;

  NotesState({required this.allNotes, required this.selectedClass, required this.selectedSubject, required this.filteredNotes});

  NotesState copyWith({List<NoteModel>? allNotes, String? selectedClass, String? selectedSubject, List<NoteModel>? filteredNotes}) {
    return NotesState(allNotes: allNotes ?? this.allNotes, selectedClass: selectedClass ?? this.selectedClass, selectedSubject: selectedSubject ?? this.selectedSubject, filteredNotes: filteredNotes ?? this.filteredNotes);
  }
}

class NotesLoading extends NotesState {
  NotesLoading() : super(allNotes: [], selectedClass: '9th', selectedSubject: 'Science', filteredNotes: []);
}
