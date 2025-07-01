import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final Duration startAt;

  const FullScreenVideoPlayer({required this.controller, required this.startAt});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  @override
  void initState() {
    super.initState();
    _enterFullScreen();
    widget.controller.seekTo(widget.startAt);
    widget.controller.play();
  }

  @override
  void dispose() {
    _exitFullScreen();
    super.dispose();
  }

  Future<void> _enterFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Future<void> _exitFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(widget.controller),
                VideoProgressIndicator(
                  widget.controller,
                  allowScrubbing: true, //
                  padding: const EdgeInsets.all(8),
                  colors: const VideoProgressColors(playedColor: Colors.red, backgroundColor: Colors.grey),
                ), //
                Positioned(top: media.height * 0.05, right: media.width * 0.02, child: IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 30), onPressed: () => Navigator.of(context).pop())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
