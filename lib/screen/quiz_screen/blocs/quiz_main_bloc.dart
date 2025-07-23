import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/quiz_screen/blocs/quiz_main_event.dart';
import 'package:visual_learning/screen/quiz_screen/blocs/quiz_main_state.dart';

import '../../all_content/bloc/quiz_chapter/qiuz_chapter_bloc.dart';
import '../../all_content/bloc/quiz_chapter/qiuz_chapter_event.dart';
import '../../notes/models/notes_model.dart';

class QuizMainBloc extends Bloc<GetQuizList, QuizMainState> {
  QuizMainBloc() : super(InItialGetNotesList()) {
    on<GetQuizList>((event, emit) {
      emit(IsLoadingGetNotesList());
      List<NoteModel> notes = [];
      notes.clear();
      print(event.selectSubject);
      print(event.id);
      print(event.token);
      BlocProvider.of<QiuzChapterBloc>(event.context).add(LoadedChapterQuiz(token: event.token, context: event.context, id: event.id));
      // BlocProvider.of<QiuzChapterBloc>(event.context).Response?.data.subjects.forEach((element) {
      //   var subject = element.subjectName;
      //   element.chapters.forEach((element) => notes.add(NoteModel(title: element.chapterName, className: '9th', subject: subject, id: "${element.chapterId}")));
      // });
      // emit(LoadedGetNotesList(filteredNotes: _filterNotes(notes, event.selectSubject)));
    });
  }
  List<NoteModel> _filterNotes(List<NoteModel> notes, String subject) {
    return notes.where((note) => note.subject == subject).toList();
  }
}
