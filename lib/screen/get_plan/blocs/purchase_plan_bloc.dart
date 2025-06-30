import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/get_plan/blocs/purchase_plan_event.dart';
import 'package:visual_learning/screen/get_plan/blocs/purchase_plan_state.dart';

import '../../../repo/api_repository_lmp.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseInitial()) {
    on<StartPurchase>((event, emit) async {
      emit(PurchaseLoading());
      try {
        Map<String, dynamic> body = {"user_id": event.userId, "plan_id": event.planId, 'auth': event.token};
        final responce = await ApiRepositoryImpl().purchasePlan(body: body);
        if (responce["status"] == true) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(PurchaseSuccess());
          ;
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));

          emit(PurchaseFailure(error: 'Something went wrong!'));
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(PurchaseFailure(error: 'Something went wrong!'));
      } catch (e) {
        emit(PurchaseFailure(error: 'Something went wrong!'));
      }
    });
  }
}
