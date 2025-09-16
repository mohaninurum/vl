import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../../constant/widgets/video_file_player.dart';
import '../../../constant/widgets/you_player.dart';
import '../../widgets/appBarWidget.dart';
import 'full_screen_video.dart';

class VideoContentDetailScreen extends StatefulWidget {
  final String language;
  final String selectClassName;
  final String selectChapterName;
  final String selectTopicName;
  final String videoUrl;
  final String descriptions;
  final String videoType;

  const VideoContentDetailScreen({super.key, required this.language, required this.selectClassName, required this.selectChapterName, required this.selectTopicName, required this.videoUrl, required this.descriptions, required this.videoType});

  @override
  State<VideoContentDetailScreen> createState() => _VideoContentDetailScreenState();
}

class _VideoContentDetailScreenState extends State<VideoContentDetailScreen> {
  late YoutubePlayerController _controller;
  VideoPlayerController? _videoController;
  bool _isPlayerReady = false;
  bool isYouTube = false;
  bool _isMuted = false;
  @override
  void initState() {
    super.initState();
    try {
      print("Video initial.......");
      if (widget.videoType.toString() == "2") {
        isYouTube = true;
      } else {
        isYouTube = false;
      }
    } catch (e) {
      print("Video error:-$e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
        ? SafeArea(
          child: Scaffold(
            appBar: AppBarWidget(),
            backgroundColor: const Color(0xFFF2F5FA),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01),
                child: Column(
                  children: [
                    // Info card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                      padding: EdgeInsets.all(media.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          _buildInfoRow("Class :", widget.selectClassName), //
                          _buildInfoRow("Chapter :", widget.selectChapterName),
                          _buildInfoRow("Topic :", widget.selectTopicName), //
                          _buildInfoRow("Language :", widget.language),
                        ],
                      ),
                    ),
                    SizedBox(height: media.height * 0.03),

                    // Video player
                    YouPlayer(yUrl: widget.videoUrl),

                    SizedBox(height: media.height * 0.035),

                    // Description
                    Row(children: [Text(AppString.descriptionText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))]),
                    SizedBox(height: media.height * 0.02),
                    SizedBox(width: double.infinity, child: Text(widget.descriptions, overflow: TextOverflow.clip, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color))),
                  ],
                ),
              ),
            ),
          ),
        )
        : Scaffold(
          appBar: AppBarWidget(),
          backgroundColor: const Color(0xFFF2F5FA),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.01),
              child: Column(
                children: [
                  // Info card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    padding: EdgeInsets.all(media.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        _buildInfoRow("Class :", widget.selectClassName), //
                        _buildInfoRow("Chapter :", widget.selectChapterName),
                        _buildInfoRow("Topic :", widget.selectTopicName), //
                        _buildInfoRow("Language :", widget.language),
                      ],
                    ),
                  ),
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
