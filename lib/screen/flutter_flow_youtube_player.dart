/*
Copyright 2021 Sarbagya Dhaubanjar. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// const kYoutubeAspectRatio = 16 / 9;
//
// class FlutterFlowYoutubePlayer extends StatefulWidget {
//   const FlutterFlowYoutubePlayer({
//     super.key,
//     required this.url,
//     this.width,
//     this.height,
//     this.autoPlay = true,
//     this.mute = false,
//     this.looping = false,
//     this.showControls = true,
//     this.showFullScreen = true,
//     this.pauseOnNavigate = false,
//     this.strictRelatedVideos = false,
//   });
//
//   final String url;
//   final double? width;
//   final double? height;
//   final bool autoPlay;
//   final bool mute;
//   final bool looping;
//   final bool showControls;
//   final bool showFullScreen;
//   final bool pauseOnNavigate;
//   final bool strictRelatedVideos;
//
//   @override
//   State<FlutterFlowYoutubePlayer> createState() =>
//       _FlutterFlowYoutubePlayerState();
// }
//
// class _FlutterFlowYoutubePlayerState extends State<FlutterFlowYoutubePlayer> {
//   late YoutubePlayerController _controller;
//   String? _videoId;
//   StreamSubscription? _playerStateSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }
//
//   @override
//   void dispose() {
//     _playerStateSubscription?.cancel();
//     _controller.close();
//     super.dispose();
//   }
//
//   double get width => widget.width == null || widget.width! >= double.infinity
//       ? MediaQuery.sizeOf(context).width
//       : widget.width!;
//
//   double get height =>
//       widget.height == null || widget.height! >= double.infinity
//           ? width / kYoutubeAspectRatio
//           : widget.height!;
//
//   void _initializePlayer() {
//     final videoId = _convertUrlToId(widget.url);
//     if (videoId == null) return;
//     _videoId = videoId;
//     _controller = YoutubePlayerController.fromVideoId(
//       videoId: videoId,
//       autoPlay: widget.autoPlay,
//       params: YoutubePlayerParams(
//         mute: widget.mute,
//         loop: widget.looping,
//         showControls: widget.showControls,
//         showFullscreenButton: widget.showFullScreen,
//         strictRelatedVideos: widget.strictRelatedVideos,
//         // CRITICAL: This prevents the pause issue
//         playsInline: true, // Keep video inline, handle fullscreen manually
//         enableJavaScript: true,
//       ),
//     );
//
//     // Listen to state changes and keep playing
//     _playerStateSubscription = _controller.listen((event) {
//       // Auto-resume if paused unexpectedly (but not if ended)
//       if (event.playerState == PlayerState.paused) {
//         Future.delayed(const Duration(milliseconds: 100), () {
//           if (mounted) {
//             _controller.playVideo();
//           }
//         });
//       }else{
//
//       }
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//
//     return Container(
//       width: isLandscape ? MediaQuery.sizeOf(context).width : width,
//       height: isLandscape ? MediaQuery.sizeOf(context).height : height,
//       color: Colors.black,
//       child: Stack(
//         children: [
//           Center(
//             child: AspectRatio(
//               aspectRatio: kYoutubeAspectRatio,
//               child: YoutubePlayer(
//                 controller: _controller,
//                 aspectRatio: kYoutubeAspectRatio,
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
//
// String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
//   assert(url.isNotEmpty, 'Url cannot be empty');
//   if (!url.contains("http") && url.length == 11) return url;
//   if (trimWhitespaces) url = url.trim();
//   for (final regex in [
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//   ]) {
//     final match = regex.firstMatch(url);
//     if (match != null && match.groupCount >= 1) return match.group(1);
//   }
//   return null;
// }
// const kYoutubeAspectRatio = 16 / 9;
// final _youtubeFullScreenControllerMap = <String, YoutubePlayerController>{};
//
// class FlutterFlowYoutubePlayer extends StatefulWidget {
//   const FlutterFlowYoutubePlayer({
//     super.key,
//     required this.url,
//     this.width,
//     this.height,
//     this.autoPlay = true,
//     this.mute = false,
//     this.looping = false,
//     this.showControls = true,
//     this.showFullScreen = true,
//     this.pauseOnNavigate = false, // video continues playing
//     this.strictRelatedVideos = false,
//   });
//
//   final String url;
//   final double? width;
//   final double? height;
//   final bool autoPlay;
//   final bool mute;
//   final bool looping;
//   final bool showControls;
//   final bool showFullScreen;
//   final bool pauseOnNavigate;
//   final bool strictRelatedVideos;
//
//   @override
//   State<FlutterFlowYoutubePlayer> createState() =>
//       _FlutterFlowYoutubePlayerState();
// }
//
// class _FlutterFlowYoutubePlayerState extends State<FlutterFlowYoutubePlayer>
//     with RouteAware {
//   YoutubePlayerController? _controller;
//   String? _videoId;
//   _YoutubeFullScreenWrapperState? _youtubeWrapper;
//   bool _subscribedRoute = false;
//
//   bool get handleFullScreen =>
//       !kIsWeb && widget.showFullScreen && _youtubeWrapper != null;
//
//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }
//
//   @override
//   void dispose() {
//     if (!handleFullScreen || _youtubeWrapper?._controller == null) {
//       if (_subscribedRoute) {
//         // optional: unsubscribe route observer
//       }
//       _controller?.close();
//       _youtubeFullScreenControllerMap[_videoId]?.close();
//       _youtubeFullScreenControllerMap.remove(_videoId);
//     }
//     super.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
//       _subscribedRoute = true;
//     }
//   }
//
//   @override
//   void didPushNext() {
//     // Do nothing to allow video to continue playing
//   }
//
//   double get width => widget.width == null || widget.width! >= double.infinity
//       ? MediaQuery.sizeOf(context).width
//       : widget.width!;
//
//   double get height =>
//       widget.height == null || widget.height! >= double.infinity
//           ? width / kYoutubeAspectRatio
//           : widget.height!;
//
//   void initializePlayer() {
//     if (!mounted) return;
//
//     final videoId = _convertUrlToId(widget.url);
//     if (videoId == null) return;
//
//     _videoId = videoId;
//     _youtubeWrapper = YoutubeFullScreenWrapper.of(context);
//
//     if (handleFullScreen &&
//         _youtubeFullScreenControllerMap.containsKey(_videoId)) {
//       _controller = _youtubeFullScreenControllerMap[_videoId]!;
//       _youtubeFullScreenControllerMap.clear();
//     } else {
//       _controller = YoutubePlayerController.fromVideoId(
//         videoId: videoId,
//         autoPlay: widget.autoPlay,
//         params: YoutubePlayerParams(
//           mute: widget.mute,
//           loop: widget.looping,
//           showControls: widget.showControls,
//           showFullscreenButton: widget.showFullScreen,
//           strictRelatedVideos: widget.strictRelatedVideos,
//         ),
//       );
//     }

//
//     if (handleFullScreen) {
//       _controller!.setFullScreenListener((isFullScreen) {
//         if (isFullScreen) {
//           // Force landscape on full-screen
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.landscapeLeft,
//             DeviceOrientation.landscapeRight,
//           ]);
//           _youtubeFullScreenControllerMap[_videoId!] = _controller!;
//           _youtubeWrapper!.updateYoutubePlayer(_controller, _videoId);
//         } else {
//           // Return to portrait when exiting full-screen
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//             DeviceOrientation.portraitDown,
//           ]);
//           _youtubeWrapper!.updateYoutubePlayer(); // will NOT pause video
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => FittedBox(
//     fit: BoxFit.cover,
//     child: SizedBox(
//       height: height,
//       width: width,
//       child: _controller != null
//           ? handleFullScreen
//           ? YoutubePlayerScaffold(
//         controller: _controller!,
//         builder: (_, player) => player,
//         autoFullScreen: false,
//         gestureRecognizers:
//         const <Factory<TapGestureRecognizer>>{},
//         enableFullScreenOnVerticalDrag: false,
//       )
//           : YoutubePlayer(
//         keepAlive: true,
//         controller: _controller!,
//         gestureRecognizers:
//         const <Factory<TapGestureRecognizer>>{},
//         enableFullScreenOnVerticalDrag: false,
//       )
//           : Container(color: Colors.transparent),
//     ),
//   );
// }
//
// /// Wraps the page to properly handle full-screen YouTube playback.
// class YoutubeFullScreenWrapper extends StatefulWidget {
//   const YoutubeFullScreenWrapper({super.key, required this.child});
//
//   final Widget child;
//
//   static _YoutubeFullScreenWrapperState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_YoutubeFullScreenWrapperState>();
//
//   @override
//   State<YoutubeFullScreenWrapper> createState() =>
//       _YoutubeFullScreenWrapperState();
// }
//
// class _YoutubeFullScreenWrapperState extends State<YoutubeFullScreenWrapper> {
//   YoutubePlayerController? _controller;
//   String? _videoId;
//
//   void updateYoutubePlayer([
//     YoutubePlayerController? controller,
//     String? videoId,
//   ]) =>
//       setState(() {
//         _controller = controller;
//         _videoId = videoId;
//         // Do NOT call playVideo() here to preserve current playback state
//       });
//
//   @override
//   void dispose() {
//     _controller?.close();
//     _youtubeFullScreenControllerMap.remove(_videoId);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => _controller != null
//       ? YoutubePlayerScaffold(
//     controller: _controller!,
//     builder: (_, player) => player,
//     enableFullScreenOnVerticalDrag: false,
//   )
//       : widget.child;
// }
//
// /// Convert YouTube URL to video ID
// String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
//   assert(url.isNotEmpty, 'Url cannot be empty');
//   if (!url.contains("http") && url.length == 11) return url;
//   if (trimWhitespaces) url = url.trim();
//   for (final regex in [
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//   ]) {
//     final match = regex.firstMatch(url);
//     if (match != null && match.groupCount >= 1) return match.group(1);
//   }
//   return null;
// }

// HEMANT
// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/gestures.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// const kYoutubeAspectRatio = 16 / 9;
// final _youtubeFullScreenControllerMap = <String, YoutubePlayerController>{};
//
// class FlutterFlowYoutubePlayer extends StatefulWidget {
//   const FlutterFlowYoutubePlayer({
//     super.key,
//     required this.url,
//     this.width,
//     this.height,
//     this.autoPlay = true,
//     this.mute = false,
//     this.looping = false,
//     this.showControls = true,
//     this.showFullScreen = true,
//     this.pauseOnNavigate = false,
//     this.strictRelatedVideos = false,
//   });
//
//   final String url;
//   final double? width;
//   final double? height;
//   final bool autoPlay;
//   final bool mute;
//   final bool looping;
//   final bool showControls;
//   final bool showFullScreen;
//   final bool pauseOnNavigate;
//   final bool strictRelatedVideos;
//
//   @override
//   State<FlutterFlowYoutubePlayer> createState() =>
//       _FlutterFlowYoutubePlayerState();
// }
//
// class _FlutterFlowYoutubePlayerState extends State<FlutterFlowYoutubePlayer>
//     with RouteAware {
//   YoutubePlayerController? _controller;
//   String? _videoId;
//   _YoutubeFullScreenWrapperState? _youtubeWrapper;
//   StreamSubscription? _playerStateSubscription;
//   bool _subscribedRoute = false;
//
//   bool get handleFullScreen =>
//       !kIsWeb && widget.showFullScreen && _youtubeWrapper != null;
//
//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }
//
//   @override
//   void dispose() {
//     if (!handleFullScreen || _youtubeWrapper?._controller == null) {
//       if (_subscribedRoute) {}
//       _controller?.close();
//       _youtubeFullScreenControllerMap[_videoId]?.close();
//       _youtubeFullScreenControllerMap.remove(_videoId);
//     }
//     _playerStateSubscription?.cancel();
//     super.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
//       _subscribedRoute = true;
//     }
//   }
//
//   @override
//   void didPushNext() {
//     print("didPushNext........");
//   }
//
//   double get width => widget.width == null || widget.width! >= double.infinity
//       ? MediaQuery.sizeOf(context).width
//       : widget.width!;
//
//   double get height =>
//       widget.height == null || widget.height! >= double.infinity
//           ? width / kYoutubeAspectRatio
//           : widget.height!;
//
//   void initializePlayer() {
//     if (!mounted) return;
//     final videoId = _convertUrlToId(widget.url);
//     if (videoId == null) return;
//
//     _videoId = videoId;
//     _youtubeWrapper = YoutubeFullScreenWrapper.of(context);
//
//     if (handleFullScreen &&
//         _youtubeFullScreenControllerMap.containsKey(_videoId)) {
//       _controller = _youtubeFullScreenControllerMap[_videoId]!;
//       _youtubeFullScreenControllerMap.clear();
//     } else {
//       _controller = YoutubePlayerController.fromVideoId(
//         videoId: videoId,
//         autoPlay: widget.autoPlay,
//         params: YoutubePlayerParams(
//           mute: widget.mute,
//           loop: widget.looping,
//           showControls: widget.showControls,
//           showFullscreenButton: widget.showFullScreen,
//           strictRelatedVideos: widget.strictRelatedVideos,
//         ),
//       );
//     }
//
//     print("handleFullScreen:: $handleFullScreen");
//     if (handleFullScreen) {
//       _controller!.setFullScreenListener((fullScreen) {
//
//         if (fullScreen) {
//           // entering fullscreen → landscape
//           _youtubeFullScreenControllerMap[_videoId!] = _controller!;
//           _youtubeWrapper!.updateYoutubePlayer(_controller, _videoId);
//
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.landscapeLeft,
//             DeviceOrientation.landscapeRight,
//           ]);
//           SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//         } else {
//           // exiting fullscreen → portrait
//           _youtubeWrapper!.updateYoutubePlayer();
//
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//             DeviceOrientation.portraitDown,
//           ]);
//           SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//         }
//       });
//     }
//
//     _playerStateSubscription = _controller?.listen((event) {
//       if (event.playerState == PlayerState.paused &&
//           event.fullScreenOption.locked == true) {
//         Future.delayed(const Duration(milliseconds: 100), () {
//           if (mounted) {
//             _controller?.playVideo();
//           }
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => FittedBox(
//     fit: BoxFit.cover,
//     child: SizedBox(
//       height: height,
//       width: width,
//       child: _controller != null
//           ? handleFullScreen
//           ? YoutubePlayerScaffold(
//         controller: _controller!,
//         builder: (_, player) => player,
//         autoFullScreen: false,
//         gestureRecognizers: const <Factory<
//             TapGestureRecognizer>>{},
//         enableFullScreenOnVerticalDrag: false,
//       )
//           : YoutubePlayer(
//         controller: _controller!,
//         gestureRecognizers: const <Factory<
//             TapGestureRecognizer>>{},
//         enableFullScreenOnVerticalDrag: true,
//       )
//           : Container(color: Colors.transparent),
//     ),
//   );
// }
//
// /// Wraps the page in order to properly show the YouTube video when fullscreen.
// class YoutubeFullScreenWrapper extends StatefulWidget {
//   YoutubeFullScreenWrapper({Key? key, required this.child}) : super(key: key);
//
//   final Widget child;
//
//   static _YoutubeFullScreenWrapperState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_YoutubeFullScreenWrapperState>();
//
//   @override
//   State<YoutubeFullScreenWrapper> createState() =>
//       _YoutubeFullScreenWrapperState();
// }
//
// class _YoutubeFullScreenWrapperState extends State<YoutubeFullScreenWrapper> {
//   YoutubePlayerController? _controller;
//   String? _videoId;
//
//   void updateYoutubePlayer([
//     YoutubePlayerController? controller,
//     String? videoId,
//   ]) =>
//       setState(() {
//         _controller = controller;
//         _videoId = videoId;
//       });
//
//   @override
//   void dispose() {
//     _controller?.close();
//     _youtubeFullScreenControllerMap.remove(_videoId);
//
//     // always reset to portrait on exit
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _controller?.setFullScreenListener((value) {
//       print("FULLSCREEN STATE: $value");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => _controller != null
//       ? YoutubePlayerScaffold(
//     controller: _controller!,
//     builder: (_, player) => player,
//     enableFullScreenOnVerticalDrag: false,
//   )
//       : widget.child;
// }
//
// String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
//   assert(url.isNotEmpty, 'Url cannot be empty');
//   if (!url.contains("http") && (url.length == 11)) return url;
//   if (trimWhitespaces) url = url.trim();
//   for (final regex in [
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//   ]) {
//     final match = regex.firstMatch(url);
//     if (match != null && match.groupCount >= 1) return match.group(1);
//   }
//   return null;
// }
//-----------------
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

const kYoutubeAspectRatio = 16 / 9;
final _youtubeFullScreenControllerMap = <String, YoutubePlayerController>{};

class FlutterFlowYoutubePlayer extends StatefulWidget {
  const FlutterFlowYoutubePlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.autoPlay = true,
    this.mute = false,
    this.looping = false,
    this.showControls = true,
    this.showFullScreen = true,
    this.pauseOnNavigate = false,
    this.strictRelatedVideos = false,
  });

  final String url;
  final double? width;
  final double? height;
  final bool autoPlay;
  final bool mute;
  final bool looping;
  final bool showControls;
  final bool showFullScreen;
  final bool pauseOnNavigate;
  final bool strictRelatedVideos;

  @override
  State<FlutterFlowYoutubePlayer> createState() =>
      _FlutterFlowYoutubePlayerState();
}

class _FlutterFlowYoutubePlayerState extends State<FlutterFlowYoutubePlayer>
    with RouteAware {
  YoutubePlayerController? _controller;
  String? _videoId;
  _YoutubeFullScreenWrapperState? _youtubeWrapper;
  StreamSubscription? _playerStateSubscription;
  bool _subscribedRoute = false;

  bool get handleFullScreen =>
      !kIsWeb && widget.showFullScreen && _youtubeWrapper != null;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    if (!handleFullScreen || _youtubeWrapper?._controller == null) {
      _controller?.close();
      _youtubeFullScreenControllerMap[_videoId]?.close();
      _youtubeFullScreenControllerMap.remove(_videoId);
    }
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
      final routeObserver = ModalRoute.of(context)!.settings.arguments as RouteObserver?;
      if (routeObserver != null && !_subscribedRoute) {
        routeObserver.subscribe(this, ModalRoute.of(context)!);
        _subscribedRoute = true;
      }
    }
  }

  @override
  void didPushNext() {
    if (widget.pauseOnNavigate) {
      _controller?.pauseVideo();
    }
  }

  @override
  void didPopNext() {
    if (widget.pauseOnNavigate && widget.autoPlay) {
      _controller?.playVideo();
    }
  }

  double get width => widget.width == null || widget.width! >= double.infinity
      ? MediaQuery.sizeOf(context).width
      : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
          ? width / kYoutubeAspectRatio
          : widget.height!;

  void initializePlayer() {
    if (!mounted) return;
    final videoId = _convertUrlToId(widget.url);
    if (videoId == null) {
      debugPrint('Invalid YouTube URL: ${widget.url}');
      return;
    }

    _videoId = videoId;
    _youtubeWrapper = YoutubeFullScreenWrapper.of(context);

    if (handleFullScreen &&
        _youtubeFullScreenControllerMap.containsKey(_videoId)) {
      _controller = _youtubeFullScreenControllerMap[_videoId]!;
      _youtubeFullScreenControllerMap.clear();
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: widget.autoPlay,
        params: YoutubePlayerParams(
          mute: widget.mute,
          loop: widget.looping,
          showControls: widget.showControls,
          showFullscreenButton: widget.showFullScreen,
          strictRelatedVideos: widget.strictRelatedVideos,
        ),
      );
    }



    // if (handleFullScreen) {
    //   _controller!.setFullScreenListener((fullScreen) async {
    //     if (fullScreen) {
    //       // Enter full-screen: Rotate to landscape
    //       _youtubeFullScreenControllerMap[_videoId!] = _controller!;
    //       _youtubeWrapper!.updateYoutubePlayer(_controller, _videoId);
    //
    //       await SystemChrome.setPreferredOrientations([
    //         DeviceOrientation.landscapeLeft,
    //         DeviceOrientation.landscapeRight,
    //       ]);
    //       // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //     } else {
    //       // Exit full-screen: Rotate to portrait
    //       _youtubeWrapper!.updateYoutubePlayer();
    //
    //       await SystemChrome.setPreferredOrientations([
    //         DeviceOrientation.landscapeLeft,
    //         DeviceOrientation.landscapeRight,
    //       ]);
    //       // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    //     }
    //   });
    // }

    _playerStateSubscription = _controller?.listen((event) {
      if (event.playerState == PlayerState.paused &&
          event.fullScreenOption.locked == true) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            _controller?.playVideo();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: width,
    child:  YoutubePlayerScaffold(
      controller: _controller!,
      builder: (_, player) => player,
      autoFullScreen: false,
      gestureRecognizers: const <Factory<TapGestureRecognizer>>{},
      enableFullScreenOnVerticalDrag: false,
    )
  );
}

class YoutubeFullScreenWrapper extends StatefulWidget {
  const YoutubeFullScreenWrapper({super.key, required this.child});

  final Widget child;

  static _YoutubeFullScreenWrapperState? of(BuildContext context) =>
      context.findAncestorStateOfType<_YoutubeFullScreenWrapperState>();

  @override
  State<YoutubeFullScreenWrapper> createState() =>
      _YoutubeFullScreenWrapperState();
}

class _YoutubeFullScreenWrapperState extends State<YoutubeFullScreenWrapper> {
  YoutubePlayerController? _controller;
  String? _videoId;

  void updateYoutubePlayer([
    YoutubePlayerController? controller,
    String? videoId,
  ]) =>
      setState(() {
        _controller = controller;
        _videoId = videoId;
      });

  @override
  void dispose() {
    _controller?.close();
    _youtubeFullScreenControllerMap.remove(_videoId);
    // Reset orientation and UI mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller?.setFullScreenListener((value) {
      debugPrint("FULLSCREEN STATE: $value");
    });

  }

  @override
  Widget build(BuildContext context) => _controller != null
      ? YoutubePlayerScaffold(
    controller: _controller!,
    builder: (_, player) => player,
    enableFullScreenOnVerticalDrag: false,
  )
      : widget.child;
}

String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
  if (url.isEmpty) return null;
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();
  for (final regex in [
    RegExp(
      r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
    ),
    RegExp(
      r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
    ),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }
  return null;
}



//
// const kYoutubeAspectRatio = 16 / 9;
// final _youtubeFullScreenControllerMap = <String, YoutubePlayerController>{};
//
// class FlutterFlowYoutubePlayer extends StatefulWidget {
//   const FlutterFlowYoutubePlayer({
//     super.key,
//     required this.url,
//     this.width,
//     this.height,
//     this.autoPlay = true,
//     this.mute = false,
//     this.looping = false,
//     this.showControls = true,
//     this.showFullScreen = true,
//     this.pauseOnNavigate = false,
//     this.strictRelatedVideos = false,
//   });
//
//   final String url;
//   final double? width;
//   final double? height;
//   final bool autoPlay;
//   final bool mute;
//   final bool looping;
//   final bool showControls;
//   final bool showFullScreen;
//   final bool pauseOnNavigate;
//   final bool strictRelatedVideos;
//
//   @override
//   State<FlutterFlowYoutubePlayer> createState() =>
//       _FlutterFlowYoutubePlayerState();
// }
//
// class _FlutterFlowYoutubePlayerState extends State<FlutterFlowYoutubePlayer>
//     with RouteAware {
//   YoutubePlayerController? _controller;
//   String? _videoId;
//   _YoutubeFullScreenWrapperState? _youtubeWrapper;
//   StreamSubscription? _playerStateSubscription;
//   bool _subscribedRoute = false;
//
//   bool get handleFullScreen =>
//       !kIsWeb && widget.showFullScreen && _youtubeWrapper != null;
//
//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }
//
//   @override
//   void dispose() {
//
//     if (!handleFullScreen || _youtubeWrapper?._controller == null) {
//       if (_subscribedRoute) {
//
//       }
//       _controller?.close();
//       _youtubeFullScreenControllerMap[_videoId]?.close();
//       _youtubeFullScreenControllerMap.remove(_videoId);
//     }
//        _playerStateSubscription?.cancel();
//     super.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
//       _subscribedRoute = true;
//
//     }
//   }
//
//   @override
//   void didPushNext() {
//   print("didPushNext........");
//     // if (widget.pauseOnNavigate) {
//     //   _controller?.pauseVideo();
//     // }
//   }
//
//   double get width => widget.width == null || widget.width! >= double.infinity
//       ? MediaQuery.sizeOf(context).width
//       : widget.width!;
//
//   double get height =>
//       widget.height == null || widget.height! >= double.infinity
//           ? width / kYoutubeAspectRatio
//           : widget.height!;
//
//   void initializePlayer() {
//     if (!mounted) {
//       return;
//     }
//     final videoId = _convertUrlToId(widget.url);
//     if (videoId == null) {
//       return;
//     }
//     _videoId = videoId;
//     _youtubeWrapper = YoutubeFullScreenWrapper.of(context);
//
//     if (handleFullScreen &&
//         _youtubeFullScreenControllerMap.containsKey(_videoId)) {
//       _controller = _youtubeFullScreenControllerMap[_videoId]!;
//       _youtubeFullScreenControllerMap.clear();
//     } else {
//       _controller = YoutubePlayerController.fromVideoId(
//         videoId: videoId,
//         autoPlay: widget.autoPlay,
//         params: YoutubePlayerParams(
//           mute: widget.mute,
//           loop: widget.looping,
//           showControls: widget.showControls,
//           showFullscreenButton: widget.showFullScreen,
//           strictRelatedVideos: widget.strictRelatedVideos,
//         ),
//       );
//     }
//     if (handleFullScreen) {
//       _controller!.setFullScreenListener((fullScreen) {
//         if (fullScreen) {
//           _youtubeFullScreenControllerMap[_videoId!] = _controller!;
//           _youtubeWrapper!.updateYoutubePlayer(_controller, _videoId);
//
//         } else {
//           _youtubeWrapper!.updateYoutubePlayer();
//         }
//
//       });
//     }
//
//     _playerStateSubscription = _controller?.listen((event) {
//
//       // Auto-resume if paused unexpectedly (but not if ended)
//       if ( event.playerState == PlayerState.paused&&event.fullScreenOption.locked==true) {
//         Future.delayed(const Duration(milliseconds: 100), () {
//           if (mounted) {
//           //   SystemChrome.setPreferredOrientations([
//           //   DeviceOrientation.landscapeLeft,
//           //   DeviceOrientation.landscapeRight,
//           // ]);
//             _controller?.playVideo();
//           }
//         });
//       }
//       // if(handleFullScreen==false){
//       //   SystemChrome.setPreferredOrientations([
//       //     DeviceOrientation.portraitUp,
//       //     DeviceOrientation.portraitDown,
//       //   ]);
//       // }
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => FittedBox(
//         fit: BoxFit.cover,
//         child: SizedBox(
//           height: height,
//           width: width,
//           child: _controller != null
//               ? handleFullScreen
//                   ? YoutubePlayerScaffold(
//                       controller: _controller!,
//                       builder: (_, player) => player,
//                       autoFullScreen: false,
//                       gestureRecognizers: const <Factory<
//                           TapGestureRecognizer>>{},
//                       enableFullScreenOnVerticalDrag: false,
//                     )
//                   : YoutubePlayer(
//                       controller: _controller!,
//                       gestureRecognizers: const <Factory<
//                           TapGestureRecognizer>>{},
//                       enableFullScreenOnVerticalDrag: true,
//                     )
//               : Container(color: Colors.transparent),
//         ),
//       );
// }
//
// /// Wraps the page in order to properly show the YouTube video when fullscreen.
// class YoutubeFullScreenWrapper extends StatefulWidget {
//   YoutubeFullScreenWrapper({Key? key, required this.child}) : super(key: key);
//
//   final Widget child;
//
//   static _YoutubeFullScreenWrapperState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_YoutubeFullScreenWrapperState>();
//
//   @override
//   State<YoutubeFullScreenWrapper> createState() =>
//       _YoutubeFullScreenWrapperState();
// }
//
// class _YoutubeFullScreenWrapperState extends State<YoutubeFullScreenWrapper> {
//   YoutubePlayerController? _controller;
//   String? _videoId;
//
//   void updateYoutubePlayer([
//     YoutubePlayerController? controller,
//     String? videoId,
//   ]) =>
//       setState(() {
//         _controller = controller;
//         _videoId = videoId;
//       });
//
//   @override
//   void dispose() {
//     _controller?.close();
//     _youtubeFullScreenControllerMap.remove(_videoId);
//        SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//     super.dispose();
//   }
//   //
//   @override
//   void initState() {
//     _controller?.setFullScreenListener((value) {
//       print("FuLLLLLLLLLLLLLL${value}");
//     },);
//     // SystemChrome.setPreferredOrientations([
//     //   DeviceOrientation.landscapeLeft,
//     //   DeviceOrientation.landscapeRight,
//     // ]);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) => _controller != null
//       ? YoutubePlayerScaffold(
//           controller: _controller!,
//           builder: (_, player) => player,
//           enableFullScreenOnVerticalDrag: false,
//         )
//       : widget.child;
// }
//
// String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
//   assert(url.isNotEmpty, 'Url cannot be empty');
//   if (!url.contains("http") && (url.length == 11)) return url;
//   if (trimWhitespaces) url = url.trim();
//   for (final regex in [
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(
//       r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
//     ),
//     RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//   ]) {
//     final match = regex.firstMatch(url);
//     if (match != null && match.groupCount >= 1) return match.group(1);
//   }
//   return null;
// }






