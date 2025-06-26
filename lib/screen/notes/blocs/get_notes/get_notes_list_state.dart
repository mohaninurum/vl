import '../../models/notes_model.dart';

abstract class GetNotesListState {}

class InItialGetNotesList extends GetNotesListState {}

class IsLoadingGetNotesList extends GetNotesListState {}

class LoadedGetNotesList extends GetNotesListState {
  final List<NoteModel> filteredNotes;
  LoadedGetNotesList({required this.filteredNotes});
}
