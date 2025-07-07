import '../models/models.dart';
import 'favorite_bloc.dart';

class FavoriteState {
  final FavoriteCategory selectedCategory;
  final List<FavoriteItem> allFavorites;
  bool isLoading;

  FavoriteState({required this.isLoading, required this.selectedCategory, required this.allFavorites});

  List<FavoriteItem> get filteredFavorites => allFavorites.where((item) => item.type == selectedCategory.name).toList();

  FavoriteState copyWith({required bool isLoading, FavoriteCategory? selectedCategory, List<FavoriteItem>? allFavorites}) {
    return FavoriteState(selectedCategory: selectedCategory ?? this.selectedCategory, allFavorites: allFavorites ?? this.allFavorites, isLoading: isLoading ?? this.isLoading);
  }
}
