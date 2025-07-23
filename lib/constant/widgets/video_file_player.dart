import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PlayVideoFromNetworkQualityUrls extends StatefulWidget {
  final netUrl;
  const PlayVideoFromNetworkQualityUrls({Key? key, this.netUrl}) : super(key: key);

  @override
  State<PlayVideoFromNetworkQualityUrls> createState() => _PlayVideoFromAssetState();
}

class _PlayVideoFromAssetState extends State<PlayVideoFromNetworkQualityUrls> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.networkQualityUrls(
        videoUrls: [
          VideoQalityUrls(quality: 360, url: '${widget.netUrl}'),
          VideoQalityUrls(quality: 480, url: '${widget.netUrl}'), //
          VideoQalityUrls(quality: 720, url: '${widget.netUrl}'), //
          VideoQalityUrls(quality: 1080, url: '${widget.netUrl}'),
        ],
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: PodVideoPlayer(
            controller: controller, //
            podProgressBarConfig: const PodProgressBarConfig(
              padding:
                  kIsWeb
                      ? EdgeInsets.zero
                      : EdgeInsets.only(
                        bottom: 20, //
                        left: 20,
                        right: 20,
                      ),
              playingBarColor: Colors.blue,
              circleHandlerColor: Colors.blue,
              backgroundColor: Colors.blueGrey,
            ),

            matchVideoAspectRatioToFrame: true,
          ),
        ),
      ),
    );
  }
}
