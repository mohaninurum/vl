abstract class GetNotesListEvent {}

class GetQuizList extends GetNotesListEvent {
  final context;
  final String id;
  final token;
  final selectSubject;
  GetQuizList({required this.id, required this.token, this.context, this.selectSubject});
}
