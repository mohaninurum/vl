import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_learning/screen/get_plan/blocs/purchase_plan_event.dart';
import 'package:visual_learning/screen/get_plan/blocs/purchase_plan_state.dart';

import '../../../repo/api_repository_lmp.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../auth/login_screen/blocs/login_event.dart';

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
          userCheckIsLogin(event.context);
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
  userCheckIsLogin(context) async {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    // loginBloc.add(GoogleLogOutEvent(context));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loginBloc.add(GoogleIsLoginEvent(context: context, displayName: "${user.displayName}", email: "${user.email}", providerId: user.providerData[0].providerId, signInMethod: user.providerData[0].providerId));
      } else if (email != null) {
        loginBloc.add(EmailChanged(email));
        loginBloc.add(PasswordChanged("$password"));
        loginBloc.add(LoginSubmitted(context));
      } else {}
    });
  }
}
