import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import 'cancel_subscription_event.dart';
import 'cancel_subscription_state.dart';

class CancelSubscriptionBloc extends Bloc<CancelSubscriptionEvent, CancelSubscriptionState> {
  CancelSubscriptionBloc() : super(CancelInitial()) {
    on<CancelSubscriptionRequested>(_onCancelSubscriptionRequested);
  }

  Future<void> _onCancelSubscriptionRequested(CancelSubscriptionRequested event, Emitter<CancelSubscriptionState> emit) async {
    emit(CancelLoading());
    try {
      Map<String, dynamic> body = {"auth": event.token};
      final response = await ApiRepositoryImpl().cancelPlan(id: event.userId, body: body);
      if (response["status"] == true) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(response["message"])));
        emit(CancelSuccess());
        // userCheckIsLogin(event.context);
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(response["message"])));
        emit(CancelFailure(error: 'Something went wrong!'));
      }
    } on TimeoutException {
      ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(content: Text('Request timed out. Please try again later.')));
      emit(CancelFailure(error: 'Timeout Error'));
    } catch (e) {
      emit(CancelFailure(error: e.toString()));
    }
  }
}
