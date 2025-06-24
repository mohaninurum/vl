import '../models/notifications_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationLoaded(this.notifications);
}

class NotificationEmpty extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}
