abstract class CategorySelectedEvent {}

class CategorySelected extends CategorySelectedEvent {
  final String category;
  final String id;
  CategorySelected({required this.category, required this.id});
}
