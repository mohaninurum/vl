// my_account_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';
import 'package:visual_learning/constant/app_text_colors/app_text_colors.dart';
import 'package:visual_learning/screen/profile/blocs/profile_event.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../auth/login_screen/blocs/login_event.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_state.dart';
import '../widgets/logout_dailog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    print("init call profile");
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileData());
    super.initState();
  }

  String toClassName(String input) {
    return input.split(RegExp(r'[_\s]+')).map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      appBar: AppBarWidget(appTitle: 'My Account'),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [_buildProfileCard(size, state), const SizedBox(height: 16), _buildSubscriptionCard(size, state), const SizedBox(height: 16), _buildSettingsCard(size)]));
        },
      ),
    );
  }

  Widget _buildProfileCard(Size size, ProfileState state) {
    final username = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.fullName.toString() ?? 'Test User';
    final email = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.email.toString() ?? 'Test@gmail.com';
    return Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]), child: Column(children: [Container(decoration: BoxDecoration(border: Border.all(width: 4, color: AppColors.pramarycolor), borderRadius: BorderRadius.circular(50)), child: CircleAvatar(radius: size.width * 0.06, backgroundColor: Colors.purple.shade50, child: const Icon(Icons.person_pin, size: 40, color: AppColors.pramarycolor))), const SizedBox(height: 10), Text(toClassName(username), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text(email, style: const TextStyle(color: Colors.grey))]));
  }

  Widget _buildSubscriptionCard(Size size, ProfileState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Subscription Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.03),
          _buildDetailRow("Plan Name", state.planName, valueColor: AppColors.pramarycolor),
          _buildDetailRow("Plan Price", "₹ ${state.planPrice.toStringAsFixed(1)}", valueColor: Colors.green),
          _buildDetailRow("Start Date", "${state.startDate.day}/${state.startDate.month}/${state.startDate.year}"),
          _buildDetailRow("End Date", "${state.endDate.day}/${state.endDate.month}/${state.endDate.year}"),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Status", style: TextStyle(color: Colors.grey)), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: state.isActive ? Colors.green.shade100 : Colors.red.shade100, borderRadius: BorderRadius.circular(12)), child: Text(state.isActive ? "Active" : "Inactive", style: TextStyle(color: state.isActive ? Colors.green : Colors.red, fontWeight: FontWeight.bold)))]),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Account Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // showLogoutDialog(context, () {
                //   context.read<LogoutBloc>().add(UserLogoutEvent(context));
                // });
                showLogoutDialog(context, () {
                  // context.read<DrawerLogoutBloc>().add(UserLogoutEvent(context));
                  context.read<LoginBloc>().add(GoogleLogOutEvent(context));
                });
              },
              icon: Icon(Icons.logout, color: AppColors.appWhiteColor),
              label: const Text("Logout", style: TextStyle(color: AppTextColors.appTextColorWhite)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)), padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: Colors.grey)), Text(value, style: TextStyle(fontWeight: FontWeight.w500, color: valueColor ?? Colors.black))]));
  }
}
