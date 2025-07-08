abstract class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;
  final String token;
  final context;
  PerformSearch({required this.query, required this.token, this.context});
}
