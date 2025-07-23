import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Used to notify that video is loaded or not
  bool isVideoLoading = true;

  /// Controller of the WebView
  InAppWebViewController? webViewController;

  @override
  void dispose() {
    super.dispose();
    webViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isVideoLoading
            ? const Center(child: CircularProgressIndicator())
            : VimeoVideoPlayer(
              videoId: '12860646',
              isAutoPlay: true,
              onInAppWebViewCreated: (controller) {
                webViewController = controller;
              },
              onInAppWebViewLoadStart: (controller, url) {
                setState(() {
                  isVideoLoading = true;
                });
              },
              onInAppWebViewLoadStop: (controller, url) {
                setState(() {
                  isVideoLoading = false;
                });
              },
            ),
      ],
    );
  }
}
