abstract class ContactEvent {}

class LoadContactInfo extends ContactEvent {
  final context;
  final token;
  LoadContactInfo({this.context, this.token});
}
