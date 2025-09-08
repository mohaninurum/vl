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
    // Jump to top when list is built

    super.initState();
  }

  getlan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language') ?? '';
    print("Lang---get$language");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(appTitle: 'Notifications'),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotificationLoaded) {
                    print(state.notifications?.data[0].title);
                    final sortedNotifications = state.notifications?.data.reversed.toList() ?? [];
                    print(sortedNotifications[0].title);
                    return ListView.builder(
                      // controller: _scrollController,
                      // shrinkWrap: true,
                      // physics: const BouncingScrollPhysics(),
                      itemCount: sortedNotifications.length,
                      itemBuilder: (context, index) {
                        final item = sortedNotifications[index];

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
          ],
        ),
      ),
    );
  }
}
