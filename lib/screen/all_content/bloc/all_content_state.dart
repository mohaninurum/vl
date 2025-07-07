import 'package:visual_learning/screen/all_content/model/all_content_model.dart';

// class ChapterContentState {
//   final List<ChapterContentModel> chapters;
//   final ChapterContentModel? selectedChapter;
//   final bool isEnglishSelected;
//   final bool isLoading;
//   final bool isFavorite;
//   final String? selectIndex;
//
//   ChapterContentState({this.selectIndex, required this.isFavorite, required this.isEnglishSelected, required this.isLoading, required this.chapters, this.selectedChapter});
//
//   ChapterContentState copyWith({String? selectIndex, bool? isFavorite, bool? isLoading, bool? isEnglishSelected, List<ChapterContentModel>? chapters, ChapterContentModel? selectedChapter}) {
//     return ChapterContentState(selectIndex: selectIndex ?? this.selectIndex, isLoading: isLoading ?? this.isLoading, isEnglishSelected: isEnglishSelected ?? this.isEnglishSelected, chapters: chapters ?? this.chapters, selectedChapter: selectedChapter ?? this.selectedChapter, isFavorite: isFavorite ?? this.isFavorite);
//   }
// }
class ChapterContentState {
  final List<ChapterContentModel> chapters;
  final ChapterContentModel? selectedChapter;
  final bool isLoading;
  final bool isLoading2;
  final bool isEnglishSelected;
  final Set<int> favoriteIndexes;
  final int? selectIndex;

  const ChapterContentState({required this.chapters, this.selectedChapter, this.isLoading = false, this.isLoading2 = false, this.isEnglishSelected = true, this.favoriteIndexes = const {}, this.selectIndex});

  ChapterContentState copyWith({List<ChapterContentModel>? chapters, ChapterContentModel? selectedChapter, bool? isLoading, bool? isLoading2, bool? isEnglishSelected, Set<int>? favoriteIndexes, int? selectIndex}) {
    return ChapterContentState(chapters: chapters ?? this.chapters, selectedChapter: selectedChapter ?? this.selectedChapter, isLoading: isLoading ?? this.isLoading, isLoading2: isLoading2 ?? this.isLoading2, isEnglishSelected: isEnglishSelected ?? this.isEnglishSelected, favoriteIndexes: favoriteIndexes ?? this.favoriteIndexes, selectIndex: selectIndex ?? this.selectIndex);
  }
}
