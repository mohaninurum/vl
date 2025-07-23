import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoPlayer extends StatefulWidget {
  const ChewieVideoPlayer({super.key});

  @override
  State<ChewieVideoPlayer> createState() => _ChewieVideoPlayerState();
}

class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  final Map<String, String> qualityUrls = {'1080p': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', '720p': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', '480p': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'};

  String selectedQuality = '1080p';

  @override
  void initState() {
    super.initState();
    _initializePlayer(qualityUrls[selectedQuality]!);
  }

  Future<void> _initializePlayer(String url) async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(videoPlayerController: _videoPlayerController, autoPlay: true, looping: false, allowFullScreen: true, allowMuting: true, showControls: true);

    setState(() {});
  }

  Future<void> _changeQuality(String quality) async {
    final currentPosition = _videoPlayerController.value.position;

    await _videoPlayerController.pause();
    await _videoPlayerController.dispose();

    selectedQuality = quality;
    await _initializePlayer(qualityUrls[quality]!);

    _videoPlayerController.seekTo(currentPosition);
    _videoPlayerController.play();
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chewie Video Player")),
      body:
          _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
              ? Column(
                children: [
                  AspectRatio(aspectRatio: _videoPlayerController.value.aspectRatio, child: Chewie(controller: _chewieController!)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Quality: "),
                      DropdownButton<String>(
                        value: selectedQuality,
                        onChanged: (value) {
                          if (value != null) {
                            _changeQuality(value);
                          }
                        },
                        items:
                            qualityUrls.keys.map((String key) {
                              return DropdownMenuItem(value: key, child: Text(key));
                            }).toList(),
                      ),
                    ],
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
