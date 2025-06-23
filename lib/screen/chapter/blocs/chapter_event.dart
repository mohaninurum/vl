abstract class ChapterListEvent {}

class LoadChapterList extends ChapterListEvent {
  final context;
  String id;
  LoadChapterList({this.context, required this.id});
}
