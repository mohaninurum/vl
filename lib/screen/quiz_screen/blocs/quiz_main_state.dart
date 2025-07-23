import '../../all_content/model/quiz_chapter_model.dart';

abstract class QuizMainState {}

class InItialGetNotesList extends QuizMainState {}

class IsLoadingGetNotesList extends QuizMainState {}

class LoadedGetNotesList extends QuizMainState {
  final List<QuizItem> filteredNotes;
  LoadedGetNotesList({required this.filteredNotes});
}
