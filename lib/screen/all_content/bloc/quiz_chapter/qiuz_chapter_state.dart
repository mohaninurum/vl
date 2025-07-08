import '../../model/quiz_chapter_model.dart';

abstract class QiuzChapterState {}

class initialQuizState extends QiuzChapterState {}

class LoadingQuizState extends QiuzChapterState {}

class LoadedQuizState extends QiuzChapterState {
  QuizListResponse? questions;
  LoadedQuizState({this.questions});
}

class FailQuizState extends QiuzChapterState {}
