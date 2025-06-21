abstract class SubjectTabEvent {}

class SubjectChanged extends SubjectTabEvent {
  final int tabIndex;
  SubjectChanged(this.tabIndex);
}
