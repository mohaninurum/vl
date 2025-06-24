import '../model/all_content_model.dart';

abstract class ChapterContentEvent {}

class LoadChaptersContent extends ChapterContentEvent {
  final context;
  final id;
  final token;
  LoadChaptersContent({this.token, this.context, this.id});
}

class ChapterTapped extends ChapterContentEvent {
  final ChapterContentModel selected;
  ChapterTapped(this.selected);
}

class ToggleLanguageEvent extends ChapterContentEvent {}

class SelectChapterEvent extends ChapterContentEvent {
  final ChapterContentModel chapter;
  SelectChapterEvent(this.chapter);
}
