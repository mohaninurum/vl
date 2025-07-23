import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_learning/screen/search_screen/search_screen/pdf_view_widgets.dart';

import '../../all_content/widgets/video_avalable_info_diallog.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../favorite/widgets/video_playe_screen.dart';
import '../../widgets/appBarWidget.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/cart_notifications)widgets.dart';
import '../widgets/video_not_avalbale_dialog.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? language = '';
  @override
  void initState() {
    getlan();
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    context.read<NotificationBloc>().add(LoadNotifications(context: context, token: token));
    ;
    super.initState();
  }

  getlan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language') ?? '';
    print("Lang---get$language");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(appTitle: 'Favorites'),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotificationLoaded) {
                    return ListView.builder(
                      itemCount: state.notifications?.data.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = state.notifications!.data[index];

                        return CartNotificationsWidgets(
                          onTap: () async {
                            print("Click notifications");
                            if ((item.videoUrlEnglish ?? '').isNotEmpty || (item.videoUrlHindi ?? '').isNotEmpty) {
                              if (language == "English") {
                                if ((item.videoUrlEnglish ?? '').isNotEmpty) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Notification Video", videoUrl: item.videoUrlEnglish!, descriptions: item.description, videoType: item.videoType.toString())));
                                } else {
                                  InfoDialog.showHindiNotAvailable(context, "English");
                                }
                              } else if (language == "Hindi") {
                                if ((item.videoUrlHindi ?? '').isNotEmpty) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Notification Video", videoUrl: item.videoUrlHindi!, descriptions: item.description, videoType: item.videoType.toString())));
                                } else {
                                  InfoDialog.showHindiNotAvailable(context, "Hindi");
                                }
                              }
                            } else if ((item.contentUrl ?? '').isNotEmpty) {
                              print("pdf Link ${item.contentUrl}");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewWidgets(pdgUrl: item.contentUrl.toString())));
                            } else {
                              VideoNotAvalbaleDialog.showHindiNotAvailable(context, "");
                            }
                          },
                          item: item,
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("No notifications found."));
                  }
                },
              ),
            ),

            //       Expanded(
            //         child: BlocBuilder<NotificationBloc, NotificationState>(
            //           builder: (context, state) {
            //             if (state is NotificationLoading) {
            //         return const Center(child: CircularProgressIndicator());
            //             } else if (state is NotificationLoaded) {
            //             return ListView.builder(
            //               itemCount: state.notifications?.data.length,
            //               itemBuilder: (context, index) {
            //                 return CartNotificationsWidgets(
            //                   onTap: () async {
            //                     if (language == "English" && state.notifications?.data[index].videoUrlEnglish != '') {
            //                           Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.notifications!.data[index].videoUrlEnglish.toString(), descriptions: state.notifications!.data[index].description, videoType:"2")));
            // //
            // // if (state.notifications?.data[index].isPaid == "1") {
            // //                         if (state.filteredFavorites[index].isPurchase == '1') {
            // //                           SubscriptionDialog.show(context);
            // //                         } else if (state.filteredFavorites[index].isPurchase == "2") {
            // //                           Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlEnglish.toString(), descriptions: state.filteredFavorites[index].subtitle, videoType: state.filteredFavorites[index].videoType)));
            // //                         }
            // //                       } else if (state.filteredFavorites[index].isPaid == "2") {
            // //                         Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlEnglish.toString(), descriptions: 'test', videoType: state.filteredFavorites[index].videoType)));
            // //                       }
            //                     } else if (language == "English") {
            //                       InfoDialog.showHindiNotAvailable(context, "English");
            //                     }
            //                     if (language == "Hindi" && state.notifications?.data[index].videoUrlHindi != '') {
            //                         Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.notifications!.data[index].videoUrlHindi.toString(), descriptions: state.notifications!.data[index].description, videoType: "2")));
            //
            // // if (state.filteredFavorites[index].isPaid == "1") {
            // //                         if (state.filteredFavorites[index].isPurchase == '1') {
            // //                           SubscriptionDialog.show(context);
            // //                         } else if (state.filteredFavorites[index].isPurchase == "2") {
            // //                           Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlHindi.toString(), descriptions: state.filteredFavorites[index].subtitle, videoType: state.filteredFavorites[index].videoType)));
            // //                         }
            // //                       } else if (state.filteredFavorites[index].isPaid == "2") {
            // //                         Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlHindi.toString(), descriptions: state.filteredFavorites[index].subtitle, videoType: state.filteredFavorites[index].videoType)));
            // //                       }
            //                     } else if (language == "Hindi") {
            //                       InfoDialog.showHindiNotAvailable(context, "Hindi");
            //                     }
            //                   },
            //                   item: state.notifications?.data[index],
            //                 );
            //               },
            //             );
            //
            //           }
            //         );
            //
            // }
            //         )
          ],
        ),
      ),
    );
  }
}

//   @override
//   void initState() {
//     final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
//     context.read<NotificationBloc>().add(LoadNotifications(context: context, token: token));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(appTitle: 'Notifications'),
//       body: BlocBuilder<NotificationBloc, NotificationState>(
//         builder: (context, state) {
//           if (state is NotificationLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is NotificationLoaded) {
//             return ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: state.notifications?.data.length,
//               itemBuilder: (context, index) {
//                 return _NotificationCard(notification: state.notifications?.data[index]);
//               },
//             );
//           } else if (state is NotificationEmpty) {
//             return const Center(child: Text("No notifications yet."));
//           } else if (state is NotificationError) {
//             return Center(child: Text(state.message));
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
//
// class _NotificationCard extends StatelessWidget {
//   final NotificationItem? notification;
//
//   const _NotificationCard({required this.notification});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Icon(Icons.notifications, color: Colors.deepPurple, size: 32),
//             const SizedBox(width: 12),
//             Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(notification?.title ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.035)), const SizedBox(height: 4), Text(notification?.description ?? '', style: TextStyle(fontSize: width * 0.03, color: Colors.black87)), const SizedBox(height: 6), Text(_formatDate(DateTime.parse(notification?.createdAt ?? '')), style: TextStyle(color: Colors.grey, fontSize: width * 0.03))])),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final difference = now.difference(date);
//     if (difference.inMinutes < 60) {
//       return "${difference.inMinutes} min ago";
//     } else if (difference.inHours < 24) {
//       return "${difference.inHours} hrs ago";
//     } else {
//       return "${date.day}/${date.month}/${date.year}";
//     }
//   }
// }
