import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../blocs/logout/logout_bloc.dart';

void showLogoutDialog(BuildContext context, VoidCallback onLogout) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder:
            (context, setState) => AlertDialog(
              backgroundColor: AppColors.lightpurplecolor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text('Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: Text('Cancel', style: TextStyle(color: AppColors.appWhiteColor)),
                    ),
                    BlocConsumer<LogoutBloc, LogoutState>(
                      listener: (context, state) {
                        if (state is LogoutSuccess) {
                          // Navigator.of(context).pop(); // Close the dialog on success
                        }
                      },
                      builder: (context, state) {
                        if (state is LogoutInitial) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                              onLogout(); // Perform logout logic
                            },
                            child: Text('Logout', style: TextStyle(color: AppColors.appWhiteColor)),
                          );
                        } else if (state is LogoutLoading) {
                          return ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor1), onPressed: () {}, child: SizedBox(width: 50, child: CupertinoActivityIndicator()));
                        } else if (state is LogoutSuccess) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor1),
                            onPressed: () {
                              onLogout();
                            },
                            child: Text('Logout', style: TextStyle(color: AppColors.pramarycolor1)),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ],
            ),
      );
    },
  );
}
