import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/screen/auth/login_screen/blocs/login_bloc.dart';

import '../about/about_screen.dart';
import '../auth/login_screen/blocs/login_event.dart';
import '../contact/contact_screen/contact_screen.dart';
import '../favorite/favorite_screen/favorite_screen.dart';
import '../feedback/feedback_screen/feedback_screen.dart';
import '../language/Language_sheet_screen.dart';
import '../profile/blocs/logout/logout_bloc.dart';
import '../profile/profile_screen/profile_screen.dart';
import '../profile/widgets/logout_dailog.dart';
import '../share_learn/share_learn+screen.dart';
import '../subcriptions/subcriptions_screen.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer();

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isExpired = false;

  bool isafter = false;

  String? language = "";

  String toClassName(String input) {
    return input.split(RegExp(r'[_\s]+')).map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }

  isDateExpired(String inputDate) {
    // Parse the input date string (ensure it's in a valid format)
    DateTime expiryDate = DateTime.parse(inputDate);

    // Get the current date and time
    DateTime currentDate = DateTime.now();

    // Compare
    isExpired = expiryDate.isAfter(currentDate);
    print("Expire:-$isExpired");
  }

  int getDaysUntilExpiry(String endDateStr) {
    DateTime endDate = DateTime.parse(endDateStr);
    DateTime today = DateTime.now();

    // Only compare date (ignore time)
    DateTime cleanToday = DateTime(today.year, today.month, today.day);
    DateTime cleanEnd = DateTime(endDate.year, endDate.month, endDate.day);

    return cleanEnd.difference(cleanToday).inDays;
  }

  getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language');
    print("language");
    print(language);
  }

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var endDate = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.expiryDate ?? "2025-06-20 23:59:59";
    isDateExpired(endDate);
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
                  SizedBox(height: height * 0.05),
                  // App Logo
                  Image.asset('assets/appicons/Visuallearning trans.png', height: height * 0.12),

                  // Expired Badge
                  isExpired
                      ? SizedBox.shrink()
                      : Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 4),
                        decoration: BoxDecoration(color: isExpired ? Colors.deepPurpleAccent : Colors.red[100], borderRadius: BorderRadius.circular(8)), //
                        child: isExpired ? Text("Active", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)) : const Text('expired', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),

                  isExpired
                      ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 4),
                          decoration: BoxDecoration(color: isExpired ? Colors.deepPurpleAccent : Colors.red[100], borderRadius: BorderRadius.circular(8)), //
                          child: Text(getDaysUntilExpiry(endDate) == 0 ? "Today Expire" : "${getDaysUntilExpiry(endDate)} days left", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      )
                      : SizedBox(),
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
              leading: Icon(Icons.favorite),
              title: Text('Favorite', style: TextStyle(fontWeight: FontWeight.normal)),
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
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
              trailing: Text(language.toString(), style: TextStyle(color: Colors.grey)),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen())); // AboutUsScreen

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
