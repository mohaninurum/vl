import '../model/all_content_model.dart';

abstract class ChapterContentEvent {}

class LoadChaptersContent extends ChapterContentEvent {
  final context;
  final id;
  final token;
  final userID;
  LoadChaptersContent({this.token, this.context, this.id, this.userID});
}

class ChapterTapped extends ChapterContentEvent {
  final ChapterContentModel selected;
  ChapterTapped(this.selected);
}

class ToggleLanguageEvent extends ChapterContentEvent {}

class FavoriteEvent extends ChapterContentEvent {
  final int selectIndex;
  final String favoriteID;
  final String userID;
  final bool isfavorite;
  final context;
  final token;
  FavoriteEvent({this.token, required this.selectIndex, required this.favoriteID, required this.isfavorite, this.context, required this.userID});
}

class SelectChapterEvent extends ChapterContentEvent {
  final ChapterContentModel chapter;
  SelectChapterEvent(this.chapter);
}
