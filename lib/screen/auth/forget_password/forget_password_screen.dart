import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/auth/login_screen/login_screen.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_style/app_text_style.dart';
import '../widgets/gradient_button.dart';
import '../widgets/input_field.dart';
import 'blocs/forget_password_bloc.dart';
import 'blocs/forget_password_event.dart'; // ✅ Import correct event file
import 'blocs/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => ForgetPasswordBloc(),
      child: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state.isSuccess) {
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reset email sent successfully")));
            // Navigate or pop
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
                    height: media.height - 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/appicons/vl logoAsset 4.png", height: media.height * 0.1),

                        Text(AppString.revolutionizedText, style: const TextStyle(fontSize: 14)),
                        SizedBox(height: media.height * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: media.width * 0.04),
                          child: Column(
                            children: [
                              SizedBox(height: media.height * 0.03),
                              BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                                builder: (context, state) {
                                  return InputField(
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: AppString.enterYourEMailText,
                                    errorText: state.emailError,
                                    onChanged: (val) => context.read<ForgetPasswordBloc>().add(ForgetEmailChanged(val)), // ✅ Correct event
                                    isPaswordShow: false,
                                  );
                                },
                              ),
                              SizedBox(height: media.height * 0.01),
                            ],
                          ),
                        ),
                        SizedBox(height: media.height * 0.027),
                        BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                          builder: (context, state) {
                            return state.isSubmitting
                                ? const CircularProgressIndicator()
                                : GradientButton(
                                  text: AppString.resetPasswordText,
                                  gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.buttonColorBlue2, AppColors.buttonColorBlue1]),
                                  onPressed: () => context.read<ForgetPasswordBloc>().add(ForgetPasswordSubmitted(context)), // ✅ Correct event
                                );
                          },
                        ),
                        SizedBox(height: media.height * 0.026),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                          },
                          child: Text(AppString.goToLoginText, style: AppTextStyle.narmalBoldTextStyle),
                        ),
                      ],
                    ),
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
