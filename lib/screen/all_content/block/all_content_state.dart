import 'package:visual_learning/screen/all_content/model/all_content_model.dart';

class ChapterContentState {
  final List<ChapterContentModel> chapters;
  final ChapterContentModel? selectedChapter;
  final bool isEnglishSelected;
  ChapterContentState({required this.isEnglishSelected, required this.chapters, this.selectedChapter});

  ChapterContentState copyWith({bool? isEnglishSelected, List<ChapterContentModel>? chapters, ChapterContentModel? selectedChapter}) {
    return ChapterContentState(isEnglishSelected: isEnglishSelected ?? this.isEnglishSelected, chapters: chapters ?? this.chapters, selectedChapter: selectedChapter ?? this.selectedChapter);
  }
}
