import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/screen/auth/login_screen/blocs/login_bloc.dart';

import '../auth/login_screen/blocs/login_event.dart';
import '../auth/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    userCheckIsLogin();
  }

  userCheckIsLogin() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    print("google current user:-$currentUser");
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    // loginBloc.add(GoogleLogOutEvent(context));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Timer(const Duration(seconds: 3), () {
          print('User is signed in!');
          print("User Name:-${user.displayName}");
          print("User Email:-${user.email}");
          print("User providerID:-${user.providerData[0].providerId}");
          loginBloc.add(GoogleIsLoginEvent(context: context, displayName: "${user.displayName}", email: "${user.email}", providerId: user.providerData[0].providerId, signInMethod: user.providerData[0].providerId));
        });
      } else if (email != null) {
        Timer(const Duration(seconds: 3), () {
          loginBloc.add(EmailChanged("$email"));
          loginBloc.add(PasswordChanged("$password"));
          loginBloc.add(LoginSubmitted(context));
        });
      } else {
        Timer(const Duration(seconds: 4), () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white, // purple gradient start
              Colors.white70, // purple gradient end
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            Image.asset('assets/appicons/Visuallearning trans.png', height: size.width * 0.3),
            SizedBox(height: size.height * 0.1),
            const SizedBox(height: 20), Text("Visual Learning", style: TextStyle(color: AppColors.pramarycolor, fontSize: size.width * 0.08, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const CircularProgressIndicator(color: AppColors.pramarycolor),
          ],
        ),
      ),
    );
  }
}
