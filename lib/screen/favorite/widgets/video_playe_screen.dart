// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// import '../../../constant/app_colors/app_colors.dart';
// import '../../../constant/app_string/app_string.dart';
// import '../../../constant/app_text_colors/app_text_colors.dart';
// import '../../home_screen/model/buttomBar_model.dart';
// import '../../widgets/appBarWidget.dart';
//
// class VideoContentDetailScreen extends StatefulWidget {
//   VideoContentDetailScreen({required this.language, required this.selectClassName, required this.selectChapterName, super.key, required this.selectTopicName, required this.videoUrl, required this.descriptions});
//   final String language;
//   final String selectClassName;
//   final String selectChapterName;
//   final String selectTopicName;
//   final String videoUrl;
//   final String descriptions;
//
//   @override
//   State<VideoContentDetailScreen> createState() => _VideoContentDetailScreenState();
// }
//
// class _VideoContentDetailScreenState extends State<VideoContentDetailScreen> {
//   final List<BottomNavItemModel> navItems = [BottomNavItemModel(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'), BottomNavItemModel(icon: Icons.rss_feed_outlined, activeIcon: Icons.rss_feed, label: 'Feedback'), BottomNavItemModel(icon: Icons.phone_outlined, activeIcon: Icons.phone, label: 'Contact'), BottomNavItemModel(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile')];
//
//   // final List<ChapterContentModel> items = [ChapterContentModel(imageUrl: 'assets/images/motion1.png', title: '1. Motion', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.deepPurple), ChapterContentModel(imageUrl: 'assets/images/motion2.png', title: '2. Motion along a straight line', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.grey.shade200), ChapterContentModel(imageUrl: 'assets/images/motion3.png', title: '3. Uniform and non uniform motion', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.grey.shade300), ChapterContentModel(imageUrl: 'assets/images/motion4.png', title: '4. Basic terms use in motion', subtitle: 'Chapter: Motion', gradeLang: '9th  English', bgColor: Colors.grey.shade300)];
//
//   late YoutubePlayerController _controller;
//   bool _isPlayerReady = false;
//   @override
//   void initState() {
//     super.initState();
//
//     var videoUrl = widget.videoUrl;
//     final videoId = YoutubePlayer.convertUrlToId(videoUrl);
//
//     if (videoId != null) {
//       _controller = YoutubePlayerController(initialVideoId: videoId, flags: const YoutubePlayerFlags(autoPlay: false, mute: false))..addListener(() {
//         if (_controller.value.isReady && !_isPlayerReady) {
//           setState(() {
//             _isPlayerReady = true;
//           });
//         }
//       });
//     } else {
//       throw Exception("Invalid YouTube URL");
//     }
//   }
//
//   void _exitFullscreen() async {
//     // Restore orientation to allow rotation
//     await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//
//     // Restore system UI
//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBarWidget(),
//       backgroundColor: const Color(0xFFF2F5FA),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//                 padding: EdgeInsets.all(media.width * 0.04),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(children: [Text("Class:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectClassName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
//                           Row(children: [Text("Chapter:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectChapterName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
//                           Row(children: [Text("Topic:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectTopicName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
//                           Row(children: [Text("Language:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.language, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                   ],
//                 ),
//               ),
//               SizedBox(height: media.height * 0.03),
//
//               //     YoutubePlayer(controller: _controller, onEnded: (_) => _exitFullscreen(), showVideoProgressIndicator: true),
//               ClipRRect(
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
//                   child: YoutubePlayer(
//                     controller: _controller,
//                     showVideoProgressIndicator: true,
//                     onReady: () async {
//                       // Lock to portrait when ready
//                       // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//                     },
//                     onEnded: (_) => _exitFullscreen(),
//                     // bottomActions: [CurrentPosition(), ProgressBar(isExpanded: true)],
//                   ),
//                   // YoutubePlayerBuilder(
//                   //   onExitFullScreen: () {
//                   //     // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
//                   //     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//                   //   },
//                   //   onEnterFullScreen: () async {
//                   //     // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//                   //     //
//                   //     // // Hide status/navigation bars for immersive portrait fullscreen
//                   //     // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//                   //     // _controller.toggleFullScreenMode();
//                   //   },
//                   //   player: YoutubePlayer(
//                   //     controller: _controller,
//                   //     showVideoProgressIndicator: true,
//                   //     onReady: () async {
//                   //       // Lock to portrait when ready
//                   //       await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//                   //     },
//                   //     onEnded: (_) => _exitFullscreen(),
//                   //     bottomActions: [CurrentPosition(), ProgressBar(isExpanded: true)],
//                   //   ),
//                   //   builder: (context, player) {
//                   //     return SizedBox();
//                   //   },
//                   // ),
//                 ),
//               ),
//               // Column(
//               //   children: [
//               //     SizedBox(height: media.height * 0.035),
//               //     Row(children: [Text(AppString.descriptionText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))]),
//               //     SizedBox(height: media.height * 0.02),
//               //     SizedBox(width: double.infinity, child: Text(widget.descriptions, overflow: TextOverflow.clip, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))),
//               //   ],
//               // ),
//               SizedBox(height: media.height * 0.035),
//               Row(children: [Text(AppString.descriptionText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))]),
//               SizedBox(height: media.height * 0.02),
//               SizedBox(width: double.infinity, child: Text(widget.descriptions, overflow: TextOverflow.clip, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visual_learning/constant/widgets/you_player.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../../constant/widgets/video_file_player.dart';
import '../../video_content_detail/video_content_detail_screen/full_screen_video.dart';
import '../../widgets/appBarWidget.dart';

class VideoFavoriteDetailScreen extends StatefulWidget {
  final String videoUrl;
  final String descriptions;
  final String videoType;
  final String screen;

  const VideoFavoriteDetailScreen({super.key, required this.videoUrl, required this.descriptions, required this.videoType, required this.screen});

  @override
  State<VideoFavoriteDetailScreen> createState() => _VideoFavoriteDetailScreenState();
}

class _VideoFavoriteDetailScreenState extends State<VideoFavoriteDetailScreen> {
  // late YoutubePlayerController _controller;
  VideoPlayerController? _videoController;
  bool isYouTube = false;
  bool _isMuted = false;

  String getYoutubeVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return '';
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'] ?? '';
    }
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    // _controller.update(playbackQuality:);

    // final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    try {
      print("Video initial....... ${widget.videoType}");
      if (widget.videoType.toString() == "2") {
        // final videoId = getYoutubeVideoId("https://youtu.be/nqye02H_H6I?si=KxVppgEJqV4s-UbU");
        // print("Youtube uirl");
        // print(widget.videoUrl);
        isYouTube = true;
        // _controller = YoutubePlayerController.fromVideoId(
        //   videoId: videoId,
        //   params: const YoutubePlayerParams(
        //     showControls: true,
        //     showFullscreenButton: true,
        //     enableJavaScript: true,
        //     showVideoAnnotations: false, //
        //     enableCaption: false,
        //     strictRelatedVideos: true,
        //   ),
        // );
        //
        // // Autoplay using WidgetsBinding to wait for full init
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   _controller.loadVideoById(videoId: videoId);
        // });
        // _controller = YoutubePlayerController(initialVideoId: videoId ?? '', flags: const YoutubePlayerFlags(autoPlay: false, mute: false))..addListener(() {
        //   if (_controller.value.isReady && !_isPlayerReady) {
        //     setState(() {
        //       _isPlayerReady = true;
        //     });
        //   }
        // });
      } else {
        isYouTube = false;
        print("Video play");
        print(widget.videoUrl);
        //"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        _videoController = VideoPlayerController.network("${widget.videoUrl}")
          ..initialize().then((_) {
            setState(() {
              print("Rebuild to show video");
            }); // Rebuild to show video
            _videoController?.play();
          });
      }
    } catch (e) {
      print("Video error:-$e");
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(children: [Text(label, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), const SizedBox(width: 6), Expanded(child: Text(value, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis))]);
  }

  Widget _buildControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Video progress slider
        VideoProgressIndicator(_videoController!, allowScrubbing: true, colors: VideoProgressColors(playedColor: Colors.red, bufferedColor: Colors.grey, backgroundColor: Colors.black12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Play/Pause button
            IconButton(
              icon: Icon(_videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              onPressed: () {
                setState(() {
                  _videoController!.value.isPlaying ? _videoController?.pause() : _videoController?.play();
                });
              },
            ),
            // Mute/Unmute button
            IconButton(
              icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isMuted = !_isMuted;
                  _videoController?.setVolume(_isMuted ? 0 : 1);
                });
              },
            ),
            // Duration display
            Padding(padding: const EdgeInsets.only(right: 12), child: Text(_videoController!.value!.isInitialized ? "${_formatDuration(_videoController!.value.position)} / ${_formatDuration(_videoController!.value.duration)}" : '', style: const TextStyle(color: Colors.white))),
            IconButton(
              icon: const Icon(Icons.fullscreen_outlined, color: Colors.white),
              onPressed: () async {
                final currentPosition = await _videoController?.position;
                await Navigator.of(context).push(MaterialPageRoute(builder: (_) => FullScreenVideoPlayer(controller: _videoController!, startAt: currentPosition ?? Duration.zero)));
                setState(() {}); // refresh after returning
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return isYouTube
        ? Scaffold(
          appBar: AppBarWidget(),
          backgroundColor: const Color(0xFFF2F5FA),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01),
              child: Column(
                children: [
                  // Info card
                  Container(alignment: Alignment.center, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)), padding: EdgeInsets.all(media.width * 0.04), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.screen, style: TextStyle(color: Colors.white))])),
                  SizedBox(height: media.height * 0.03),

                  // Video player
                  YouPlayer(yUrl: widget.videoUrl),
                  // Row(
                  //   children: [
                  //     const Text("Player Size:"),
                  //     const SizedBox(width: 10),
                  //     DropdownButton<String>(
                  //       value: _selectedSize,
                  //       items:
                  //           sizeOptions.keys.map((label) {
                  //             return DropdownMenuItem(value: label, child: Text(label));
                  //           }).toList(),
                  //       onChanged: (val) {
                  //         if (val != null) {
                  //           setState(() => _selectedSize = val);
                  //           _setPlayerSize(val);
                  //           print(_selectedSize);
                  //         }
                  //       },
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: media.height * 0.035),

                  // Description
                  Row(children: [Text(AppString.descriptionText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))]),
                  SizedBox(height: media.height * 0.02),
                  SizedBox(width: double.infinity, child: Text(widget.descriptions, overflow: TextOverflow.clip, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))),
                ],
              ),
            ),
          ),
        )
        // YoutubePlayerBuilder(
        //       player: YoutubePlayer(
        //         controller: _controller,
        //         showVideoProgressIndicator: true,
        //         onReady: () {
        //           _isPlayerReady = true;
        //         },
        //         onEnded: (_) {
        //           SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        //         },
        //       ),
        //       builder: (context, player) {
        //         return Scaffold(
        //           appBar: AppBarWidget(),
        //           backgroundColor: const Color(0xFFF2F5FA),
        //           body: SafeArea(
        //             child: SingleChildScrollView(
        //               padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01),
        //               child: Column(
        //                 children: [
        //                   // Info card
        //                   Container(alignment: Alignment.center, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)), padding: EdgeInsets.all(media.width * 0.04), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.screen, style: TextStyle(color: Colors.white))])),
        //                   SizedBox(height: media.height * 0.03),
        //
        //                   // Video player
        //                   ClipRRect(borderRadius: BorderRadius.circular(15), child: Container(decoration: BoxDecoration(color: Colors.black), child: player)),
        //
        //                   SizedBox(height: media.height * 0.035),
        //
        //                   // Description
        //                   Row(children: [Text(AppString.descriptionText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))]),
        //                   SizedBox(height: media.height * 0.02),
        //                   SizedBox(width: double.infinity, child: Text(widget.descriptions, overflow: TextOverflow.clip, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //       onEnterFullScreen: () {
        //         SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        //       },
        //       onExitFullScreen: () {
        //         SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        //       },
        //     )
        : Scaffold(
          appBar: AppBarWidget(),
          backgroundColor: const Color(0xFFF2F5FA),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01),
              child: Column(
                children: [
                  // Info card
                  Container(alignment: Alignment.center, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)), padding: EdgeInsets.all(media.width * 0.04), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.screen, style: TextStyle(color: Colors.white))])),
                  SizedBox(height: media.height * 0.03),

                  // Video player
                  PlayVideoFromNetworkQualityUrls(netUrl: widget.videoUrl),

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                  //   child: Container(
                  //     decoration: BoxDecoration(color: Colors.white),
                  //     child: //
                  //         _videoController != null && _videoController!.value.isInitialized
                  //             ? Stack(
                  //               children: [
                  //                 AspectRatio(
                  //                   aspectRatio: _videoController!.value.aspectRatio, //
                  //                   child: VideoPlayer(_videoController!),
                  //                 ),
                  //                 Positioned(bottom: 0, top: 0, left: 0, right: 0, child: Align(alignment: Alignment.bottomCenter, child: _buildControls())),
                  //               ],
                  //             ) //
                  //             : CircularProgressIndicator(color: AppColors.pramarycolor),
                  //   ),
                  // ),
                  SizedBox(height: media.height * 0.035),

                  // Description
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

// import 'package:flutter/material.dart';
// import 'package:last_pod_player/last_pod_player.dart';
// import 'package:visual_learning/screen/favorite/widgets/y_player.dart';
//
// class VideoFavoriteDetailScreen extends StatefulWidget {
//   final String videoUrl;
//   final String descriptions;
//   final String videoType;
//   final String screen;
//
//   const VideoFavoriteDetailScreen({super.key, required this.videoUrl, required this.descriptions, required this.videoType, required this.screen});
//
//   @override
//   State<VideoFavoriteDetailScreen> createState() => _VideoFavoriteDetailScreenState();
// }
//
// class _VideoFavoriteDetailScreenState extends State<VideoFavoriteDetailScreen> {
//   late final PodPlayerController controller;
// bool isLoading = true;
// @override
// void initState() {
//   loadVideo();
//   super.initState();
// }
//
// void loadVideo() async {
//   controller = PodPlayerController(playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/A3ltMaM6noM'), podPlayerConfig: const PodPlayerConfig(autoPlay: true, isLooping: false, videoQualityPriority: [720, 360]))..initialise();
//
//   // final urls = await PodPlayerController.getYoutubeUrls('https://youtu.be/omDVyNyQ3ug?si=KjMnTJZLnv5A_zU6');
//   setState(() => isLoading = false);
//   // controller = PodPlayerController(playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls!), podPlayerConfig: const PodPlayerConfig())..initialise();
// }
//
// @override
// void dispose() {
//   controller.dispose();
//   super.dispose();
// }

//   @override
//   Widget build(BuildContext context) {
//     return HomePage();
//     //return isLoading ? const Center(child: CircularProgressIndicator()) : Center(child: PodVideoPlayer(controller: controller));
//   }
// }

//   OmniPlaybackController? _controller;
//
//   int selectedQuality = 720; // Default preferred quality
//   final List<int> qualityOptions = [1080, 720, 480, 360];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('YouTube Player with Quality Selector')),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 500,
//             child: OmniVideoPlayer(
//               key: ValueKey(selectedQuality), // Important for rebuilding with new quality
//               callbacks: VideoPlayerCallbacks(
//                 onControllerCreated: (controller) {
//                   _controller = controller;
//                   setState(() {});
//                 },
//               ),
//               options: VideoPlayerConfiguration(videoSourceConfiguration: VideoSourceConfiguration.youtube(videoUrl: Uri.parse("https://youtu.be/omDVyNyQ3ug"), preferredQualities: [144, 240]), playerTheme: OmniVideoPlayerThemeData().copyWith(icons: VideoPlayerIconTheme().copyWith(error: Icons.warning), overlays: VideoPlayerOverlayTheme().copyWith(backgroundColor: Colors.black, alpha: 20)), playerUIVisibilityOptions: PlayerUIVisibilityOptions().copyWith(showMuteUnMuteButton: true, showFullScreenButton: true, useSafeAreaForBottomControls: false), customPlayerWidgets: CustomPlayerWidgets().copyWith(thumbnailFit: BoxFit.fitWidth)),
//             ),
//           ),
//
//           const SizedBox(height: 12),
//
//           // Quality Selector Dropdown
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 const Text('Quality:'),
//                 const SizedBox(width: 8),
//                 DropdownButton<int>(
//                   value: selectedQuality,
//                   items: qualityOptions.map((q) => DropdownMenuItem(value: q, child: Text('${q}p'))).toList(),
//                   onChanged: (newQuality) {
//                     if (newQuality != null) {
//                       setState(() {
//                         selectedQuality = newQuality;
//                         _controller = null; // Reset to trigger rebuild
//                       });
//                     }
//                   },
//                 ),
//                 const Spacer(),
//
//                 // Play / Pause Button
//                 if (_controller != null)
//                   AnimatedBuilder(
//                     animation: Listenable.merge([_controller]),
//                     builder: (context, _) {
//                       final isPlaying = _controller!.isPlaying;
//                       return IconButton(
//                         icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//                         onPressed: () {
//                           isPlaying ? _controller!.pause() : _controller!.play();
//                         },
//                       );
//                     },
//                   )
//                 else
//                   const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
// }
////youtubeExplode//////////////////
//   final yt = YoutubeExplode();
//
//   VideoPlayerController? _videoController;
//   List<MuxedStreamInfo> _availableQualities = [];
//   MuxedStreamInfo? _selectedStream;
//   bool _isInitialized = false;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadStreams();
//   }
//
//   Future<void> _loadStreams() async {
//     setState(() => _isLoading = true);
//
//     try {
//       final videoId = VideoId(widget.videoUrl);
//       final manifest = await yt.videos.streamsClient.getManifest(videoId);
//       final muxed = manifest.muxed;
//
//       if (muxed.isEmpty) throw Exception("No playable muxed streams available.");
//
//       // Create modifiable copy to sort
//       _availableQualities = List<MuxedStreamInfo>.from(muxed);
//
//       // Sort by resolution (highest first)
//       _availableQualities.sort((a, b) => b.videoResolution.height.compareTo(a.videoResolution.height));
//
//       _selectedStream = _availableQualities.first;
//       await _initializePlayer(_selectedStream!);
//     } catch (e) {
//       debugPrint("Error loading video: $e");
//       if (mounted) {
//         showDialog(context: context, builder: (_) => AlertDialog(title: const Text("Error"), content: Text(e.toString()), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))]));
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   Future<void> _initializePlayer(MuxedStreamInfo stream) async {
//     _videoController?.dispose();
//     _videoController = VideoPlayerController.network(stream.url.toString());
//     await _videoController!.initialize();
//     setState(() {
//       _isInitialized = true;
//     });
//     _videoController!.play();
//   }
//
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     yt.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("YouTube Native Player")),
//       body:
//           _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : Column(
//                 children: [
//                   if (_isInitialized) AspectRatio(aspectRatio: _videoController!.value.aspectRatio, child: VideoPlayer(_videoController!)),
//                   const SizedBox(height: 16),
//                   if (_availableQualities.isNotEmpty)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Quality: "),
//                         DropdownButton<MuxedStreamInfo>(
//                           value: _selectedStream,
//                           items: _availableQualities.map((stream) => DropdownMenuItem(value: stream, child: Text('${stream.videoResolution.height}p'))).toList(),
//                           onChanged: (val) async {
//                             if (val != null) {
//                               setState(() {
//                                 _selectedStream = val;
//                                 _isInitialized = false;
//                               });
//                               await _initializePlayer(val);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//     );
//   }
// }

//   late YoutubePlayerController _controller;
//   String selectedQuality = 'hd720';
//
//   final List<String> qualities = ['highres', 'hd1080', 'hd720', 'large', 'medium', 'small', 'tiny', 'auto'];
//
//   @override
//   void initState() {
//     super.initState();
//
//     final videoId = YoutubePlayerController.convertUrlToId("https://youtu.be/omDVyNyQ3ug");
//
//     _controller = YoutubePlayerController.fromVideoId(videoId: videoId!, params: const YoutubePlayerParams(showControls: true, showFullscreenButton: true, enableJavaScript: true, playsInline: true));
//   }
//
//   Future<void> _setPlaybackQuality(String quality) async {
//     final script = '''
//       if (typeof player !== 'undefined' && player.setPlaybackQuality) {
//         console.log("Setting quality to $quality");
//         player.setPlaybackQuality('$quality');
//       } else {
//         console.warn("Player not ready");
//       }
//     ''';
//
//     // await _controller.evaluateJavascript(script);
//     // _controller.update(playbackQuality: "tiny");
//     setState(() {
//       selectedQuality = quality;
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerScaffold(
//       controller: _controller,
//       builder: (context, player) {
//         return Scaffold(
//           appBar: AppBar(title: const Text("YouTube Quality Control"), backgroundColor: Colors.redAccent),
//           body: Column(
//             children: [
//               AspectRatio(aspectRatio: 16 / 9, child: player),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     const Text("Select Quality:", style: TextStyle(fontSize: 16)),
//                     const SizedBox(width: 10),
//                     DropdownButton<String>(
//                       value: selectedQuality,
//                       items:
//                           qualities.map((q) {
//                             return DropdownMenuItem(value: q, child: Text(q.toUpperCase()));
//                           }).toList(),
//                       onChanged: (val) {
//                         if (val != null) {
//                           _setPlaybackQuality(val);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
