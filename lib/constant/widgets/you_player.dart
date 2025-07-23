import 'package:flutter/material.dart';
import 'package:y_player/y_player.dart';

class YouPlayer extends StatefulWidget {
  final yUrl;
  const YouPlayer({super.key, required this.yUrl});

  @override
  State<YouPlayer> createState() => _YouPlayerState();
}

class _YouPlayerState extends State<YouPlayer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: Colors.black87,
          child: YPlayer(
            bottomButtonBarMargin: EdgeInsets.only(bottom: 10),
            fullscreenBottomButtonBarMargin: EdgeInsets.only(bottom: 5),
            fullscreenSeekBarMargin: EdgeInsets.only(bottom: 7),
            seekBarMargin: EdgeInsets.only(bottom: 7),
            aspectRatio: 16 / 9,
            youtubeUrl: widget.yUrl,
            autoPlay: false,
            loadingWidget: CircularProgressIndicator(color: Colors.white), //
          ),
        ),
      ),
    );
  }
}
