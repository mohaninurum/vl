import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/feedback_list_model.dart';
import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackState(isSubmitting: true, isLoading: true)) {
    on<SubmitFeedback>((event, emit) async {
      emit(state.copyWith(isSubmitting: false, isLoading: true));
      try {
        Map<String, dynamic> body = {"full_name": event.name, "feedback": event.message, 'auth': event.token};
        final responce = await ApiRepositoryImpl().postFeedback(body: body);
        if (responce["status"] == true) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(state.copyWith(isSubmitting: true, isLoading: true));
          add(GetFeedbackList(context: event.context, token: event.token));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(state.copyWith(isSubmitting: true, isLoading: true));
        }
      } on TimeoutException catch (e) {
        emit(state.copyWith(isSubmitting: true, isLoading: true));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        emit(state.copyWith(isSubmitting: true, isLoading: true));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
    on<GetFeedbackList>((event, emit) async {
      // try {
      //   print("load feedback");
      //   emit(state.copyWith(isSubmitting: true, isLoading: false));
      //   Map<String, dynamic> body = {'auth': event.token};
      //   final responce = await ApiRepositoryImpl().getFeedbackList(body: body);
      //   if (responce["status"] == true) {
      //     FeedbackResponse Response = FeedbackResponse.fromJson(responce);
      //
      //     emit(FeedbackState(feedbacks: Response, isSubmitting: true, isLoading: true));
      //   } else {
      //     ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
      //   }
      // }
      try {
        print("load feedback");
        emit(state.copyWith(isSubmitting: true, isLoading: false));

        Map<String, dynamic> body = {'auth': event.token};
        final responce = await ApiRepositoryImpl().getFeedbackList(body: body);

        if (responce["status"] == true) {
          FeedbackResponse response = FeedbackResponse.fromJson(responce);

          // Sort feedbacks by created_at descending
          response.data.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          emit(FeedbackState(feedbacks: response, isSubmitting: true, isLoading: true));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"] ?? "Something went wrong")));
        }
      } catch (e) {
        print("Feedback fetch error: $e");
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(state.copyWith(isSubmitting: true, isLoading: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: true, isLoading: true));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
