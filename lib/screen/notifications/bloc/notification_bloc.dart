import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/notifications_model.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
  }

  void _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    await Future.delayed(Duration(seconds: 2)); // simulate API call

    final notifications = <NotificationModel>[NotificationModel(title: "Welcome", message: "Thank you for joining us!", date: DateTime.now()), NotificationModel(title: "New Feature", message: "Explore the new AI editing tools now!", date: DateTime.now())]; //.subtract(Duration(hours: 1))

    if (notifications.isEmpty) {
      emit(NotificationEmpty());
    } else {
      emit(NotificationLoaded(notifications));
    }
  }
}
