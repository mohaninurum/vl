import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/api_repository_lmp.dart';
import '../../login_screen/blocs/login_bloc.dart';
import '../../login_screen/blocs/login_event.dart';
import '../models/register_model.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  RegisterResponse? loginResponse;
  SignUpBloc() : super(SignUpState()) {
    on<FullNameChanged>((event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<ReferralCode>((event, emit) => emit(state.copyWith(referralCode: event.referralCode)));

    on<EmailSignChanged>((event, emit) {
      final error = event.email.contains("@") ? null : "Enter a valid email";
      emit(state.copyWith(email: event.email, emailError: error));
    });

    on<MobileChanged>((event, emit) => emit(state.copyWith(mobile: event.mobile)));

    on<PasswordChangedSign>((event, emit) {
      final error = event.password.length >= 3 ? null : "Password must be 6+ chars";
      emit(state.copyWith(password: event.password, passwordError: error));
    });

    on<ConfirmPasswordChanged>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));

    on<TogglePasswordVisibilitySign>((event, emit) => emit(state.copyWith(showPassword: !state.showPassword)));

    on<ToggleConfirmPasswordVisibilitySign>((event, emit) => emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword)));

    on<SubmitPressed>((event, emit) async {
      if (!state.isValid) {
        String? error;
        if (state.password != state.confirmPassword) {
          error = "Passwords do not match";
        }
        emit(state.copyWith(generalError: error));
      } else {
        print("submmit Pressesd");
        emit(state.copyWith(isSubmitting: true, isSuccess: false, generalError: null));
        try {
          final body = {"full_name": state.fullName, "mobile": state.mobile, "email": state.email, "password": state.password, "referred_code": state.referralCode};
          // Future.delayed(Duration(seconds: 5));
          final loginresponce = await ApiRepositoryImpl().signUp(body: body);
          if (loginresponce["status"] == true) {
            BlocProvider.of<LoginBloc>(event.context).add(EmailChanged(state.email));
            BlocProvider.of<LoginBloc>(event.context).add(PasswordChanged(state.password));
            BlocProvider.of<LoginBloc>(event.context).add(LoginSubmitted(event.context));
            // loginResponse = RegisterResponse.fromJson(loginresponce);
            print("register");
            print(loginResponse?.data?.fullName);
            emit(state.copyWith(isSubmitting: false, isSuccess: true));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
            emit(state.copyWith(isSubmitting: false, isSuccess: false));
          }
          print(body);
          emit(state.copyWith(isSubmitting: false, isSuccess: false, generalError: null));
        } on TimeoutException catch (e) {
          emit(state.copyWith(isSubmitting: false, isSuccess: false));
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        } catch (e) {
          emit(state.copyWith(isSubmitting: false, isSuccess: false));
          print("error :-$e");
          // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
        }
      }
    });
  }
}
