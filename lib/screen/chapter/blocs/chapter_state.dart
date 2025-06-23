import '../model/class_detail_model.dart';

abstract class ChapterListState {}

class InitailChapterList extends ChapterListState {}

class IsLoadingChapterList extends ChapterListState {}

class LoadedChapterList extends ChapterListState {
  ClassDetailResponse? classDetailResponse;
  LoadedChapterList({this.classDetailResponse});
}

class FailChapterList extends ChapterListState {}
