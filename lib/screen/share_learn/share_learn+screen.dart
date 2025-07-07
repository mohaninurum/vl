import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/screen/share_learn/widgets/helpOptionTile.dart';
import 'package:visual_learning/screen/share_learn/widgets/share_step_widgets.dart';

import '../../constant/app_string/app_string.dart';
import '../auth/login_screen/blocs/login_bloc.dart';
import '../widgets/appBarWidget.dart';
import 'blocs/share_learn_bloc.dart';

class ShareScreen extends StatelessWidget {
  ShareScreen({super.key});

  String? refCode = '';

  shareApp() {
    Share.share('Check out this awesome app and Use ${AppString.referralCodeText}:- $refCode: https://play.google.com/store/apps/details?id=com.yourcompany.yourapp', subject: 'Download the Visual Learning app! ');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    refCode = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.referralCode.toString();
    return BlocProvider(
      create: (_) => ShareBloc(),
      child: Scaffold(
        appBar: AppBarWidget(appTitle: "Share & Learn"),
        // appBar: AppBar(title: const Text(")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    const Text("Share & Learn More", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 5), const Text("Get your subscription extended whenever a friend installs the app and purchases a subscription.", textAlign: TextAlign.center, style: TextStyle(fontSize: 13)), const SizedBox(height: 8), //
                    //  context.read<ShareBloc>().add(ShareNowPressed())
                    ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.pramarycolor)), onPressed: shareApp, child: const Text("Share Now", style: TextStyle(color: AppColors.appWhiteColor))),
                  ],
                ),
              ),

              const Text("How it Works?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              const ShareStepTile(number: 1, color: Colors.orange, text: 'Click on “Share Now”', icon: Icons.share),
              const ShareStepTile(number: 2, color: Colors.green, text: 'Share Visual Learning with your friends', icon: Icons.group),
              const ShareStepTile(number: 3, color: Colors.blue, text: 'Your friends get a discount of 20%', icon: Icons.discount),
              const ShareStepTile(number: 4, color: Colors.amber, text: 'Your plan gets extended when they subscribe', icon: Icons.workspace_premium),

              const Padding(padding: EdgeInsets.all(16.0), child: Text("Offer Eligibility", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "• The person you refer must be a new user with no existing account on iPrep.\n\n"
                  "• You will receive an extension on your iPrep based on the plan your friend purchases: 15 days free for quarterly plan & 1 month free for annual plan.\n\n"
                  "• No reward will be given if your friend purchases the 1-day or 7-day plan.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(height: h * 0.02),
              HelpOptionTile(icon: Icons.help_outline, title: "Frequently Asked Questions"),
              Divider(height: 1),
              HelpOptionTile(icon: Icons.description_outlined, title: "Terms and Conditions"),
              Divider(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
