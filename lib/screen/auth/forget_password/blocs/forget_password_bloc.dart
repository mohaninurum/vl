import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/api_repository_lmp.dart';
import 'forget_password_event.dart';
import 'forget_password_state.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Uncomment if using Firebase

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(const ForgetPasswordState()) {
    on<ForgetEmailChanged>((event, emit) {
      final isValid = event.email.contains('@');
      emit(state.copyWith(email: event.email, emailError: isValid ? null : 'Enter a valid email'));
    });

    on<ForgetPasswordSubmitted>((event, emit) async {
      final isValid = state.email.contains('@');
      if (!isValid) {
        emit(state.copyWith(emailError: 'Enter a valid email'));
        return;
      }
      Future.delayed(Duration(seconds: 3));
      emit(state.copyWith(isSubmitting: true, isSuccess: false));
      try {
        final body = {"email": state.email};
        final responce = await ApiRepositoryImpl().forgotPassword(body: body);
        if (responce["status"] == true) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(state.copyWith(isSubmitting: false, isSuccess: false));
        }
        emit(state.copyWith(isSubmitting: false, isSuccess: false));
      } on TimeoutException catch (e) {
        emit(state.copyWith(isSubmitting: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Something went wrong, try again.')));
        emit(state.copyWith(isSubmitting: false, isSuccess: false));
      }
    });
  }
}
