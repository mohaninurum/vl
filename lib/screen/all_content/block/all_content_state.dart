import 'package:visual_learning/screen/all_content/model/all_content_model.dart';

class ChapterContentState {
  final List<ChapterContentModel> chapters;
  final ChapterContentModel? selectedChapter;
  final bool isEnglishSelected;
  final bool isLoading;
  ChapterContentState({required this.isEnglishSelected, required this.isLoading, required this.chapters, this.selectedChapter});

  ChapterContentState copyWith({bool? isLoading, bool? isEnglishSelected, List<ChapterContentModel>? chapters, ChapterContentModel? selectedChapter}) {
    return ChapterContentState(isLoading: isLoading ?? this.isLoading, isEnglishSelected: isEnglishSelected ?? this.isEnglishSelected, chapters: chapters ?? this.chapters, selectedChapter: selectedChapter ?? this.selectedChapter);
  }
}
