import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/notes_model.dart';
import '../get_subject/get_subject_bloc.dart';
import 'get_notes_list_event.dart';
import 'get_notes_list_state.dart';

class GetNotesListBloc extends Bloc<GetNotesListEvent, GetNotesListState> {
  GetNotesListBloc() : super(InItialGetNotesList()) {
    on<GetNotesList>((event, emit) {
      emit(IsLoadingGetNotesList());
      List<NoteModel> notes = [];
      notes.clear();
      BlocProvider.of<GetSubjectBloc>(event.context).subjectList?.data.subjects.forEach((element) {
        var subject = element.subjectName;
        element.chapters.forEach((element) => notes.add(NoteModel(title: element.chapterName, className: '9th', subject: subject, id: "${element.chapterId}")));
      });
      emit(LoadedGetNotesList(filteredNotes: _filterNotes(notes, event.selectSubject)));
    });
  }
  List<NoteModel> _filterNotes(List<NoteModel> notes, String subject) {
    return notes.where((note) => note.subject == subject).toList();
  }
}

//_filterNotes(notes, state.selectedClass, state.selectedSubject)
// List<NoteModel> _filterNotes(List<NoteModel> notes, String className, String subject) {
//   return notes.where((note) => note.className == className && note.subject == subject).toList();
// }
