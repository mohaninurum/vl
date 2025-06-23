import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/auth/login_screen/blocs/login_bloc.dart';

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

  userCheckIsLogin() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    print("google current user:-$currentUser");
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    // loginBloc.add(GoogleLogOutEvent(context));
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
    // FirebaseAuth.instance.authStateChanges().listen((user) {
    //   if (user != null) {
    //     print('User is signed in!');
    //     print("User Name:-${user.displayName}");
    //     print("User Email:-${user.email}");
    //     print("User providerID:-${user.providerData[0].providerId}");
    //     loginBloc.add(GoogleIsLoginEvent(context: context, displayName: "${user.displayName}", email: "${user.email}", providerId: user.providerData[0].providerId, signInMethod: user.providerData[0].providerId));
    //
    //     Timer(const Duration(seconds: 4), () {
    //       if (loginBloc.isLogin) {
    //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
    //       }
    //     });
    //   } else {
    //     print('User is signed out!');
    //     loginBloc.isLogin = false;
    //     Timer(const Duration(seconds: 4), () {
    //       if (loginBloc.isLogin) {
    //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
    //       } else {
    //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
    //       }
    //     });
    //   }
    // });
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
              Color(0xFF8E2DE2), // purple gradient start
              Color(0xFF4A00E0), // purple gradient end
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset('assets/appicons/Visuallearning trans.png', height: size.width * 0.3), const SizedBox(height: 20), Text("Visual Learning", style: TextStyle(color: Colors.white, fontSize: size.width * 0.08, fontWeight: FontWeight.bold)), const SizedBox(height: 8), const CircularProgressIndicator(color: Colors.white)]),
      ),
    );
  }
}
