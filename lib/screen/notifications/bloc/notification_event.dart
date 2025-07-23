abstract class NotificationEvent {}

class LoadNotifications extends NotificationEvent {
  final token;
  final context;
  LoadNotifications({this.token, this.context});
}
