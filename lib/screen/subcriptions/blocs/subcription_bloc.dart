import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/subcriptions/blocs/subcription_event.dart';
import 'package:visual_learning/screen/subcriptions/blocs/subcription_state.dart';

import '../../../repo/api_repository_lmp.dart';
import '../../profile/models/user_subscription_details_model.dart';
import '../models/subscription_plan_model.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(InitialSubscriptionState()) {
    on<SelectPlan>((event, emit) {
      final currentState = state;
      if (currentState is SubscriptionPlanListState) {
        emit(SubscriptionPlanListState(subscriptionPlanResponse: currentState.subscriptionPlanResponse, selectedPlanIndex: event.planIndex, subscriptionID: ''));
      }
    });

    on<GetSubscriptions>((event, emit) async {
      try {
        emit(IsLoadingSubscriptionState());
        Map<String, dynamic> body = {'auth': event.token};
        final responce = await ApiRepositoryImpl().getSubscriptionPlan(body: body);

        if (responce["status"] == true) {
          SubscriptionPlanResponse Response = SubscriptionPlanResponse.fromJson(responce);
          if (event.isSubscribe.toString() == "2") {
            final userSubscriptionDetail = await ApiRepositoryImpl().getUserSubscription(body: body, id: event.id);
            if (userSubscriptionDetail["status"] == true) {
              print("Use subscription detial ");
              SubscriptionResponse subscriptionResponse = SubscriptionResponse.fromJson(userSubscriptionDetail);

              emit(SubscriptionPlanListState(subscriptionPlanResponse: Response, selectedPlanIndex: -1, subscriptionID: "${subscriptionResponse.data?.subscriptionPlanIdFK ?? ''}"));
            }
          } else {
            emit(SubscriptionPlanListState(subscriptionPlanResponse: Response, selectedPlanIndex: -1, subscriptionID: ''));
          }
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));

          emit(FailSubscriptionState());
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(FailSubscriptionState());
      } catch (e) {
        emit(FailSubscriptionState());
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
