import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PlayVideoFromNetwork extends StatefulWidget {
  const PlayVideoFromNetwork({Key? key}) : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  late PodPlayerController controller;
  String selectedQuality = '720p';

  final Map<String, String> qualityUrls = {'360p': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4', '480p': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4', '720p': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'};

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    controller = PodPlayerController(playVideoFrom: PlayVideoFrom.network(qualityUrls[selectedQuality]!))..initialise();
  }

  void _changeQuality(String quality) {
    setState(() {
      selectedQuality = quality;
      controller.dispose(); // Clean up old controller
      _initializePlayer(); // Load new video
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedQuality,
          onChanged: (value) {
            if (value != null) _changeQuality(value);
          },
          items:
              qualityUrls.keys.map((quality) {
                return DropdownMenuItem(value: quality, child: Text(quality));
              }).toList(),
        ),
        PodVideoPlayer(controller: controller),
      ],
    );
  }
}
