import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/constant/app_string/app_string.dart';

import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../../constant/app_text_style/app_text_style.dart';
import '../forget_password/forget_password_screen.dart';
import '../singup_screen/signup_screen.dart';
import '../widgets/gradient_button.dart';
import '../widgets/input_field.dart';
import 'blocs/login_bloc.dart';
import 'blocs/login_event.dart';
import 'blocs/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF4F6FA),
          body: InkWell(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.08),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: media.height - 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/appicons/vl logoAsset 4.png", height: media.height * 0.1),

                      const Text(AppString.revolutionizedText, style: TextStyle(fontSize: 14)),
                      SizedBox(height: media.height * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: media.width * 0.03),
                        child: Column(
                          children: [
                            SizedBox(height: media.height * 0.01),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return InputField(keyboardType: TextInputType.emailAddress, hintText: AppString.enterYourEMailText, errorText: state.emailError, onChanged: (val) => context.read<LoginBloc>().add(EmailChanged(val)), isPaswordShow: false);
                              },
                            ),
                            SizedBox(height: media.height * 0.02),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return InputField(keyboardType: TextInputType.visiblePassword, hintText: AppString.passwordText, obscureText: !state.isPasswordVisible, isPaswordShow: state.isPasswordVisible, onSuffixTap: () => context.read<LoginBloc>().add(TogglePasswordVisibility()), onChanged: (val) => context.read<LoginBloc>().add(PasswordChanged(val)), errorText: state.passwordError);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: media.height * 0.027),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return state.isSubmitting ? const CircularProgressIndicator() : GradientButton(text: AppString.loginText, gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.buttonColorBlue2, AppColors.buttonColorBlue1]), onPressed: () => context.read<LoginBloc>().add(LoginSubmitted(context)));
                        },
                      ),
                      SizedBox(height: media.height * 0.04),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return state.isSubmitGoogle
                              ? const CircularProgressIndicator()
                              : GradientButton(
                                text: AppString.loginWithGoogleText,
                                gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.buttonColorOrange2, AppColors.buttonColorOrange1]),
                                onPressed: () {
                                  context.read<LoginBloc>().add(GoogleSignInEvent(context));
                                },
                              );
                        },
                      ),
                      SizedBox(height: media.height * 0.025),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                        },
                        child: const Text(AppString.forgotPasswordText, style: AppTextStyle.narmalBoldTextStyle),
                      ),
                      SizedBox(height: media.height * 0.022),
                      Text(AppString.donHaveAnAccountText, style: TextStyle(color: AppTextColors.appTextColorblackless)),
                      SizedBox(height: media.height * 0.03),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
                        },
                        child: Text(AppString.signUpText, style: AppTextStyle.narmalBoldTextStyle),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
