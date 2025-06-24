import '../models/notes_content_model.dart';

abstract class NotesContentState {}

class InitailNotesContent extends NotesContentState {}

class IsLoadingNotesContent extends NotesContentState {}

class LoadedNotesContent extends NotesContentState {
  NotesPdfResponse? notesPdfResponse;
  LoadedNotesContent({this.notesPdfResponse});
}

class FailNotesContent extends NotesContentState {}
