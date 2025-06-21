import '../../model/category_model.dart';

abstract class CategoryEvent {}

class CategoryClicked extends CategoryEvent {
  final Category category;
  CategoryClicked(this.category);
}

class LoadCategory extends CategoryEvent {
  final context;
  LoadCategory(this.context);
}
