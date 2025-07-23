import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({super.key});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late PodPlayerController _controller;
  bool _isLoading = true;
  Map<int, String> _videoQualities = {};
  int? _selectedQuality;

  final String youtubeUrl = 'https://youtu.be/2Vv-BfVoq4g'; // Replace with your own video

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      final urls = await PodPlayerController.getYoutubeUrls(youtubeUrl);

      if (urls == null || urls.isEmpty) {
        debugPrint('❌ No video qualities found.');
        return;
      }

      // _videoQualities = urls;
      // _selectedQuality = urls.keys.first;

      _controller = PodPlayerController(playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls), podPlayerConfig: const PodPlayerConfig(autoPlay: true, isLooping: false, videoQualityPriority: [1080, 720, 480, 360]))..initialise();

      setState(() => _isLoading = false);
    } catch (e) {
      debugPrint('❌ Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Widget _buildQualityDropdown() {
  //   return DropdownButton<int>(
  //     dropdownColor: Colors.grey[900],
  //     value: _selectedQuality,
  //     items: _videoQualities.keys.map((quality) {
  //       return DropdownMenuItem(
  //         value: quality,
  //         child: Text(
  //           '${quality}p',
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //       );
  //     }).toList(),
  //     onChanged: (selected) {
  //       if (selected != null) {
  //         setState(() => _selectedQuality = selected);
  //         _controller.changeVideoQuality(selected);
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YouTube Player'), backgroundColor: Colors.black),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  AspectRatio(aspectRatio: 16 / 9, child: PodVideoPlayer(controller: _controller)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Select Quality:', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      // _buildQualityDropdown(),
                    ],
                  ),
                ],
              ),
    );
  }
}
