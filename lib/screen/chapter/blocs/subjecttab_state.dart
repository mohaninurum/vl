import '../model/chapter_list_model.dart';

class SubjectTabState {
  final List<ChapterListModel> chapters;
  final int selectedTab;

  SubjectTabState({required this.chapters, required this.selectedTab});

  SubjectTabState copyWith({List<ChapterListModel>? chapters, int? selectedTab}) {
    return SubjectTabState(chapters: chapters ?? this.chapters, selectedTab: selectedTab ?? this.selectedTab);
  }
}
