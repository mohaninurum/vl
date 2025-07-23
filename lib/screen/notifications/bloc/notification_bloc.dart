import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/notifications_responce_model.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
  }

  void _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    await Future.delayed(Duration(seconds: 2)); // simulate API call
    try {
      Map<String, dynamic> body = {'auth': event.token};
      final responce = await ApiRepositoryImpl().notificationList(body: body);
      if (responce["status"] == true) {
        NotificationResponse Response = NotificationResponse.fromJson(responce);
        //        final notifications = <NotificationModel>[NotificationModel(title: "Welcome", message: "Thank you for joining us!", date: DateTime.now()), NotificationModel(title: "New Feature", message: "Explore the new AI editing tools now!", date: DateTime.now())]; //.subtract(Duration(hours: 1))

        if (Response.data.isEmpty) {
          emit(NotificationEmpty());
        } else {
          emit(NotificationLoaded(notifications: Response));
        }
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
      }
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
    } catch (e) {
      print("error :-$e");
      // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
    }
  }
}
