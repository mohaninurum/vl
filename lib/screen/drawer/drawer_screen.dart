import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/screen/auth/login_screen/blocs/login_bloc.dart';

import '../about/about_screen.dart';
import '../auth/login_screen/blocs/login_event.dart';
import '../contact/contact_screen/contact_screen.dart';
import '../feedback/feedback_screen/feedback_screen.dart';
import '../language/Language_sheet_screen.dart';
import '../profile/blocs/logout/logout_bloc.dart';
import '../profile/profile_screen/profile_screen.dart';
import '../profile/widgets/logout_dailog.dart';
import '../share_learn/share_learn+screen.dart';
import '../subcriptions/subcriptions_screen.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer();
  String toClassName(String input) {
    return input.split(RegExp(r'[_\s]+')).map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final username = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.fullName.toString() ?? '';
    final email = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.email.toString() ?? '';
    return Drawer(
      shadowColor: Colors.black54,
      elevation: 2,
      backgroundColor: AppColors.lightpurplecolor,

      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.pramarycolor,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  // App Logo
                  Image.asset('assets/appicons/Visuallearning trans.png', height: height * 0.13),
                  SizedBox(height: height * 0.01),
                  // Expired Badge
                  Container(padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 4), decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(8)), child: const Text('expired', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/300', // Replace with user profile image URL
                ),
              ),
              title: Text(toClassName(username), style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('$email', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey)),
              trailing: Icon(Icons.arrow_forward_ios, size: height * 0.019),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.subscriptions),
              title: Text('Subscription', style: TextStyle(fontWeight: FontWeight.normal)),
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionScreen()));
                // Navigate to profile screen
              },
            ),

            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language', style: TextStyle(fontWeight: FontWeight.normal)),
              onTap: () {
                Navigator.pop(context);
                showLanguageBottomSheet(context);
                // Navigate to profile screen
              },
              trailing: Text("English", style: TextStyle(color: Colors.grey)),
            ),
            ListTile(
              leading: Icon(Icons.screen_share_outlined),
              title: Text('Share and Earn', style: TextStyle(fontWeight: FontWeight.normal)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShareScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.rss_feed_outlined),
              title: Text('Feedback', style: TextStyle(fontWeight: FontWeight.normal)),
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact us', style: TextStyle(fontWeight: FontWeight.normal)),
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About us', style: TextStyle(fontWeight: FontWeight.normal)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));

                // Navigate to support screen
              },
            ),

            SizedBox(height: height * 0.02),
            // Logout at the bottom
            BlocBuilder<LogoutBloc, LogoutState>(
              builder: (context, state) {
                return ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout', style: TextStyle(fontWeight: FontWeight.normal)),
                  onTap: () {
                    showLogoutDialog(context, () {
                      // context.read<DrawerLogoutBloc>().add(UserLogoutEvent(context));
                      context.read<LoginBloc>().add(GoogleLogOutEvent(context));
                    });

                    // Navigator.pop(context);
                    // Handle logout logic here
                  },
                );
              },
            ),
            TextButton(onPressed: () {}, child: Text("Want to become an iPrep Affiliate?", style: TextStyle(color: Colors.blue))),
            Text(" Version: 1.0.0", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
