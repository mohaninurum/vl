abstract class GetSubjectEvent {}

class GetSubject extends GetSubjectEvent {
  final context;
  final String id;
  final token;
  GetSubject({required this.id, required this.token, this.context});
}
