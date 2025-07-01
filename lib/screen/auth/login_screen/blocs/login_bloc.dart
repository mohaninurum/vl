import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../repo/api_repository_lmp.dart';
import '../../../home_screen/home_screen/home_screen.dart';
import '../../models/login_model.dart';
import '../googe_auth_service.dart';
import '../login_screen.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isLogin = false;
  LoginResponse? loginResponse;
  bool isGoogleLogin = false;

  LoginBloc() : super(LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, emailError: null));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, passwordError: null));
    });
    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });
    on<LoginSubmitted>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool emailValid = state.email.contains('@');
      bool passwordValid = state.password.length >= 3;
      emit(state.copyWith(emailError: emailValid ? null : 'Invalid email', passwordError: passwordValid ? null : 'Password too short'));
      if (emailValid && passwordValid) {
        emit(state.copyWith(isSubmitting: true, isSuccess: false));
        try {
          Map<String, dynamic> body = {"email": state.email, "password": state.password};
          final loginresponce = await ApiRepositoryImpl().login(body: body);
          if (loginresponce["status"] == true) {
            emailValid = false;
            passwordValid = false;
            isGoogleLogin = false;
            await prefs.setString('email', state.email);
            await prefs.setString('password', state.password);
            loginResponse = LoginResponse.fromJson(loginresponce);
            emit(state.copyWith(isSubmitting: false, isSuccess: true));
            Navigator.pushAndRemoveUntil(event.context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
            emit(state.copyWith(isSubmitting: false, isSuccess: false));
          }
        } on TimeoutException catch (e) {
          emit(state.copyWith(isSubmitting: false, isSuccess: false));
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        } catch (e) {
          emit(state.copyWith(isSubmitting: true, isSuccess: false));
          print("error :-$e");
          // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
        }
      }
    });
    on<GoogleSignInEvent>((event, emit) async {
      emit(state.copyWith(isSubmitGoogle: true, isSuccess: false));
      final auth = await GoogeAuthService().signInWithGoogle();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("google auth login responce:-$auth");
      try {
        if (auth != null) {
          final body = {"full_name": "${auth.user?.displayName}", "email": "${auth.user?.email}", "provider_id": "${auth.credential?.providerId}", "signIn_method": "${auth.credential?.signInMethod}"};
          final loginresponce = await ApiRepositoryImpl().googleLogin(body: body);
          if (loginresponce["status"] == true) {
            print('Welcome ${loginResponse?.user?.fullName}');
            isGoogleLogin = true;
            await prefs.setString('email', state.email);
            await prefs.setString('password', state.password);
            loginResponse = LoginResponse.fromJson(loginresponce);
            emit(state.copyWith(isSubmitGoogle: true, isSuccess: true));
            Navigator.pushAndRemoveUntil(event.context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
            emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
          }
          emit(state.copyWith(isSubmitGoogle: false, isSuccess: true));
        } else {
          print("Login failed");
          emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        }
      } on TimeoutException catch (e) {
        emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
    on<GoogleIsLoginEvent>((event, emit) async {
      emit(state.copyWith(isSubmitGoogle: true, isSuccess: false));
      final auth = await GoogeAuthService().signInWithGoogle();
      print("google auth login responce:-$auth");
      try {
        if (auth != null) {
          final body = {"full_name": "${auth.user?.displayName}", "email": "${auth.user?.email}", "provider_id": "${auth.credential?.providerId}", "signIn_method": "${auth.credential?.signInMethod}"};
          final loginresponce = await ApiRepositoryImpl().googleLogin(body: body);
          if (loginresponce["status"] == true) {
            print('Welcome ${loginResponse?.user?.fullName}');
            isGoogleLogin = true;
            isLogin = true;

            loginResponse = LoginResponse.fromJson(loginresponce);
            emit(state.copyWith(isSubmitGoogle: true, isSuccess: true));
            Navigator.pushAndRemoveUntil(event.context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
          } else {
            isGoogleLogin = false;
            isLogin = false;
            // ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
            emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
          }
          emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        } else {
          isGoogleLogin = false;
          isLogin = false;
          print("Login failed");
          emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        }
      } on TimeoutException {
        isGoogleLogin = false;
        isLogin = false;
        emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        isGoogleLogin = false;
        isLogin = false;
        emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
    on<GoogleLogOutEvent>((event, emit) async {
      final auth = await GoogeAuthService().signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        Map<String, dynamic> body = {'auth': BlocProvider.of<LoginBloc>(event.context).loginResponse?.user?.token.toString() ?? ''};
        final loginresponce = await ApiRepositoryImpl().userLogout(body: body);
        if (loginresponce["status"] == true) {
          await prefs.remove('email');
          await prefs.remove('password');
          final String? email = prefs.getString('email');
          final String? password = prefs.getString('password');
          if (email == null && password == null) {
            Navigator.pushAndRemoveUntil(event.context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
            isGoogleLogin = false;
            isLogin = false;
          }
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
        }
      } on TimeoutException {
        emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        emit(state.copyWith(isSubmitGoogle: false, isSuccess: false));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }

      // Navigator.push(event.context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // emit(state.copyWith(isLogin: false));
    });
  }
}
