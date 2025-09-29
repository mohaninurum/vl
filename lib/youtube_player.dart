import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String videoUrl;

  const YoutubePlayerWidget({super.key, required this.videoUrl});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(

      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(

        autoPlay: true,
        mute: false,
        enableCaption: true,
        hideControls: false,
        controlsVisibleAtStart: true
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenYoutubePlayer(controller: _controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Column(
          children: [
            // Player with fullscreen button
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  player,
                  // Positioned(
                  //   bottom: 8,
                  //   right: 8,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.fullscreen, color: Colors.white),
                  //     onPressed: () => _openFullScreen(context),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class FullScreenYoutubePlayer extends StatelessWidget {
  final YoutubePlayerController controller;

  const FullScreenYoutubePlayer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return RotatedBox(
                quarterTurns: 1, // Rotate to landscape
                child: SizedBox(
                  width: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.width,
                  child: player,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// class YoutubePlayerWidget extends StatefulWidget {
//   final String videoId;
//
//   const YoutubePlayerWidget({super.key, required this.videoId});
//
//   @override
//   State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
// }
//
// class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     final videoId = _convertUrlToId(widget.videoId);
//     _controller = YoutubePlayerController.fromVideoId(
//       videoId:videoId??'' ,
//       autoPlay: true,
//       params: const YoutubePlayerParams(
//         showFullscreenButton: true,
//         enableCaption: true,
//         strictRelatedVideos: true,
//         showControls: true,
//         playsInline: false, // for fullscreen toggle
//       ),
//     );
//     _controller.setFullScreenListener((value) {
//       print("full......setFullScreenListener");
//       print("full.....${value}");
//
//     },);
//     _controller.listen((event) {
//       print("full.....listen${event.fullScreenOption.locked}");
//       print("full.....listen${event.fullScreenOption.enabled}");
//       print("full.....listen${event.playerState.name}");
//       print("full.....listen${event.playerState}");
//     },);
//
//   }
//
//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }
//
//
//   String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
//     assert(url.isNotEmpty, 'Url cannot be empty');
//     if (!url.contains("http") && (url.length == 11)) return url;
//     if (trimWhitespaces) url = url.trim();
//     for (final regex in [
//       RegExp(
//         r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
//       ),
//       RegExp(
//         r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
//       ),
//       RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//     ]) {
//       final match = regex.firstMatch(url);
//       if (match != null && match.groupCount >= 1) return match.group(1);
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerScaffold(
//       controller: _controller,
//       aspectRatio: 16 / 9,
//
//       builder: (context, player) {
//         return Column(
//           children: [
//             // Video Player
//             player,
//           ],
//         );
//       },
//     );
//   }
// }
