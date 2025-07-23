import '../models/models.dart';
import 'favorite_bloc.dart';

class FavoriteState {
  final FavoriteCategory selectedCategory;
  final List<FavoriteVideoItem> allFavorites;
  bool isLoading;

  FavoriteState({required this.isLoading, required this.selectedCategory, required this.allFavorites});

  FavoriteState copyWith({required bool isLoading, FavoriteCategory? selectedCategory, List<FavoriteVideoItem>? allFavorites}) {
    return FavoriteState(selectedCategory: selectedCategory ?? this.selectedCategory, allFavorites: allFavorites ?? this.allFavorites, isLoading: isLoading ?? this.isLoading);
  }
}
