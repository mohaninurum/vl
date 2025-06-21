abstract class CategorySelectedEvent {}

class CategorySelected extends CategorySelectedEvent {
  final String category;
  CategorySelected(this.category);
}
