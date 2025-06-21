import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../../constant/app_text_style/app_text_style.dart';
import '../../home_screen/home_screen/home_screen.dart';
import '../login_screen/blocs/login_bloc.dart';
import '../login_screen/blocs/login_event.dart';
import '../login_screen/blocs/login_state.dart';
import '../widgets/gradient_button.dart';
import '../widgets/input_field.dart';
import 'blocs/signup_bloc.dart';
import 'blocs/signup_event.dart';
import 'blocs/signup_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.isSuccess.toString() == "true") {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
            } else if (state.generalError != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.generalError!)));
            }
          },
          builder: (context, state) {
            return InkWell(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: media.width * 0.08, vertical: 5),
                child: SingleChildScrollView(
                  child: SizedBox(
                    // height: media.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: media.width * 0.03),
                          child: Column(
                            children: [
                              Image.asset("assets/appicons/vl logoAsset 4.png", height: media.height * 0.1),
                              const Text(AppString.revolutionizedText, style: TextStyle(fontSize: 14)),
                              SizedBox(height: media.height * 0.02),
                              InputField(hintText: AppString.fullNameText, isPaswordShow: false, onChanged: (val) => context.read<SignUpBloc>().add(FullNameChanged(val))),
                              SizedBox(height: media.height * 0.02),
                              InputField(keyboardType: TextInputType.emailAddress, hintText: AppString.enterYourEMailText, isPaswordShow: false, errorText: state.emailError, onChanged: (val) => context.read<SignUpBloc>().add(EmailSignChanged(val))),
                              SizedBox(height: media.height * 0.02),
                              InputField(keyboardType: TextInputType.phone, hintText: AppString.enterMobileNumberText, isPaswordShow: false, onChanged: (val) => context.read<SignUpBloc>().add(MobileChanged(val))),
                              SizedBox(height: media.height * 0.02),
                              InputField(keyboardType: TextInputType.visiblePassword, hintText: AppString.passwordText, obscureText: !state.showPassword, isPaswordShow: state.showPassword, onSuffixTap: () => context.read<SignUpBloc>().add(TogglePasswordVisibilitySign()), onChanged: (val) => context.read<SignUpBloc>().add(PasswordChangedSign(val)), errorText: state.passwordError),
                              SizedBox(height: media.height * 0.02),
                              InputField(keyboardType: TextInputType.visiblePassword, hintText: AppString.confirmPasswordText, obscureText: !state.showConfirmPassword, isPaswordShow: state.showConfirmPassword, onSuffixTap: () => context.read<SignUpBloc>().add(ToggleConfirmPasswordVisibilitySign()), onChanged: (val) => context.read<SignUpBloc>().add(ConfirmPasswordChanged(val))),
                              SizedBox(height: media.height * 0.02),
                              InputField(hintText: AppString.referralCodeText, isPaswordShow: false, onChanged: (val) => context.read<SignUpBloc>().add(ReferralCode(val))),
                            ],
                          ),
                        ),
                        SizedBox(height: media.height * 0.04),
                        state.isSubmitting == true
                            ? const CircularProgressIndicator()
                            : GradientButton(
                              text: AppString.signUpText,
                              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.buttonColorBlue2, AppColors.buttonColorBlue1]),
                              onPressed: () {
                                context.read<SignUpBloc>().add(SubmitPressed(context: context));
                              },
                            ),
                        SizedBox(height: media.height * 0.024),
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
                        SizedBox(height: media.height * 0.024),
                        const Text(AppString.haveAccountAlready, style: TextStyle(color: AppTextColors.appTextColorblackless)),
                        SizedBox(height: media.height * 0.03),
                        GestureDetector(onTap: () => Navigator.pop(context), child: Text(AppString.signInText, style: AppTextStyle.narmalBoldTextStyle)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
