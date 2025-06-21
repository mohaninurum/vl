abstract class ClassListEvent {}

class LoadClassList extends ClassListEvent {
  final context;
  String id;
  LoadClassList({this.context, required this.id});
}
