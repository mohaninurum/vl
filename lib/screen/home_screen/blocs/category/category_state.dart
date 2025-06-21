import '../../model/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class IsLoadingCategory extends CategoryState {}

class FialdCategoryState extends CategoryState {}

class LoadedCategoryState extends CategoryState {
  final CategoryResponseModel categoryResponseModel;
  LoadedCategoryState({required this.categoryResponseModel});
}
