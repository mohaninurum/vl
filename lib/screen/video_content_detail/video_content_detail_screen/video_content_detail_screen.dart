import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../home_screen/model/buttomBar_model.dart';
import '../../widgets/appBarWidget.dart';

class VideoContentDetailScreen extends StatefulWidget {
  VideoContentDetailScreen({required this.language, required this.selectClassName, required this.selectChapterName, super.key, required this.selectTopicName, required this.videoUrl, required this.descriptions});
  final String language;
  final String selectClassName;
  final String selectChapterName;
  final String selectTopicName;
  final String videoUrl;
  final String descriptions;

  @override
  State<VideoContentDetailScreen> createState() => _VideoContentDetailScreenState();
}

class _VideoContentDetailScreenState extends State<VideoContentDetailScreen> {
  final List<BottomNavItemModel> navItems = [BottomNavItemModel(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'), BottomNavItemModel(icon: Icons.rss_feed_outlined, activeIcon: Icons.rss_feed, label: 'Feedback'), BottomNavItemModel(icon: Icons.phone_outlined, activeIcon: Icons.phone, label: 'Contact'), BottomNavItemModel(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile')];

  // final List<ChapterContentModel> items = [ChapterContentModel(imageUrl: 'assets/images/motion1.png', title: '1. Motion', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.deepPurple), ChapterContentModel(imageUrl: 'assets/images/motion2.png', title: '2. Motion along a straight line', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.grey.shade200), ChapterContentModel(imageUrl: 'assets/images/motion3.png', title: '3. Uniform and non uniform motion', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.grey.shade300), ChapterContentModel(imageUrl: 'assets/images/motion4.png', title: '4. Basic terms use in motion', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.grey.shade300)];

  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  @override
  void initState() {
    super.initState();

    var videoUrl = widget.videoUrl;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId != null) {
      _controller = YoutubePlayerController(initialVideoId: videoId, flags: const YoutubePlayerFlags(autoPlay: false, mute: false))..addListener(() {
        if (_controller.value.isReady && !_isPlayerReady) {
          setState(() {
            _isPlayerReady = true;
          });
        }
      });
    } else {
      throw Exception("Invalid YouTube URL");
    }
  }

  void _exitFullscreen() async {
    // Restore orientation to allow rotation
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    // Restore system UI
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      backgroundColor: const Color(0xFFF2F5FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                padding: EdgeInsets.all(media.width * 0.04),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [Text("Class:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectClassName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                          Row(children: [Text("Chapter:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectChapterName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                          Row(children: [Text("Topic:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectTopicName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                          Row(children: [Text("Language:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.language, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: media.height * 0.03),

              //     YoutubePlayer(controller: _controller, onEnded: (_) => _exitFullscreen(), showVideoProgressIndicator: true),
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () async {
                      // Lock to portrait when ready
                      // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                    },
                    onEnded: (_) => _exitFullscreen(),
                    // bottomActions: [CurrentPosition(), ProgressBar(isExpanded: true)],
                  ),
                  // YoutubePlayerBuilder(
                  //   onExitFullScreen: () {
                  //     // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                  //     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                  //   },
                  //   onEnterFullScreen: () async {
                  //     // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                  //     //
                  //     // // Hide status/navigation bars for immersive portrait fullscreen
                  //     // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                  //     // _controller.toggleFullScreenMode();
                  //   },
                  //   player: YoutubePlayer(
                  //     controller: _controller,
                  //     showVideoProgressIndicator: true,
                  //     onReady: () async {
                  //       // Lock to portrait when ready
                  //       await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                  //     },
                  //     onEnded: (_) => _exitFullscreen(),
                  //     bottomActions: [CurrentPosition(), ProgressBar(isExpanded: true)],
                  //   ),
                  //   builder: (context, player) {
                  //     return SizedBox();
                  //   },
                  // ),
                ),
              ),
              // Column(
              //   children: [
              //     SizedBox(height: media.height * 0.035),
              //     Row(children: [Text(AppString.descriptionText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))]),
              //     SizedBox(height: media.height * 0.02),
              //     SizedBox(width: double.infinity, child: Text(widget.descriptions, overflow: TextOverflow.clip, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))),
              //   ],
              // ),
              SizedBox(height: media.height * 0.035),
              Row(children: [Text(AppString.descriptionText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))]),
              SizedBox(height: media.height * 0.02),
              SizedBox(width: double.infinity, child: Text(widget.descriptions, overflow: TextOverflow.clip, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))),
            ],
          ),
        ),
      ),
    );
  }
}
