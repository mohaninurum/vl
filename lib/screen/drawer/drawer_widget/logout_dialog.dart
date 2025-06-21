// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vroomo/core/utils/app_colors.dart';
// import 'package:vroomo/features/drawer/presentation/blocs/drawer_logout/drawer_logout_bloc.dart';
//
// void showLogoutDialog(BuildContext context, VoidCallback onLogout) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: Text('Logout'),
//           content: Text('Are you sure you want to logout?'),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: AppColor.blue800),
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close dialog
//                   },
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(color: AppColor.appWhite),
//                   ),
//                 ),
//                 BlocConsumer<DrawerLogoutBloc, DrawerLogoutState>(
//                   listener: (context, state) {
//                     if (state is DrawerLogoutSuccess) {
//                       // Navigator.of(context).pop(); // Close the dialog on success
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is DrawerLogoutInitial) {
//                       return ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.blue800),
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Close dialog
//                           onLogout(); // Perform logout logic
//                         },
//                         child: Text(
//                           'Logout',
//                           style: TextStyle(color: AppColor.appWhite),
//                         ),
//                       );
//                     } else if (state is DrawerLogoutLoading) {
//                       return ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.blue800),
//                         onPressed: () {},
//                         child: SizedBox(width: 50, child: CupertinoActivityIndicator()),
//                       );
//                     } else if (state is DrawerLogoutSuccess) {
//                       return ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.blue800),
//                         onPressed: () {
//                           onLogout();
//                         },
//                         child: Text(
//                           'Logout',
//                           style: TextStyle(color: AppColor.appWhite),
//                         ),
//                       );
//                     }
//                     return Container();
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     },
//   );
// }
