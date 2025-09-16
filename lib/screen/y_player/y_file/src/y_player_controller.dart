import 'dart:async'; // For Timer
import 'dart:io'; // Add for HTTP requests

import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:media_kit/media_kit.dart';
import 'package:visual_learning/screen/y_player/y_file/src/types/y_player_progress_callback.dart';
import 'package:visual_learning/screen/y_player/y_file/src/types/y_player_state_callback.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as exp;

import 'enums/y_player_status.dart';
import 'models/quality_option.dart';

/// Controller for managing the YouTube player with automatic quality adjustment.
///
/// This class handles the initialization, playback control, and state management
/// of the YouTube video player. It uses the youtube_explode_dart package to fetch
/// video information and the media_kit package for playback.
///
/// Features automatic quality adjustment based on network speed monitoring.
class YPlayerController {
  /// YouTube API client for fetching video information.
  final exp.YoutubeExplode _yt = exp.YoutubeExplode();

  /// Media player instance from media_kit.
  late final Player _player;

  /// Current status of the player.
  YPlayerStatus _status = YPlayerStatus.initial;

  /// Callback function triggered when the player's status changes.
  final YPlayerStateCallback? onStateChanged;

  /// Callback function triggered when the player's progress changes.
  final YPlayerProgressCallback? onProgressChanged;

  /// The URL of the last successfully initialized video.
  String? _lastInitializedUrl;

  /// Store the current manifest for quality changes
  exp.StreamManifest? _currentManifest;

  /// Store the current video ID
  String? _currentVideoId;

  /// Current selected quality (resolution height) - Default to 360p
  int _currentQuality = 144;

  /// Whether to force the original audio track
  bool _forceOriginalAudio = false;

  /// Add this ValueNotifier to track status changes
  final ValueNotifier<YPlayerStatus> statusNotifier;

  /// LRU cache for manifests (max 20 entries)
  static final Map<String, exp.StreamManifest> _manifestCache = {};
  static final List<String> _manifestCacheOrder = [];

  // === AUTO QUALITY ADJUSTMENT PROPERTIES ===

  /// Timer for periodic network speed monitoring
  Timer? _networkMonitorTimer;

  /// Whether automatic quality adjustment is enabled
  bool _autoQualityEnabled = true;

  /// Network speed monitoring interval in seconds
  static const int _monitoringInterval = 10;

  /// Buffer for storing recent network speed measurements
  final List<int> _networkSpeedBuffer = [];

  /// Maximum buffer size for network speed measurements
  static const int _maxBufferSize = 5;

  /// Quality change cooldown to prevent rapid switching
  DateTime? _lastQualityChange;

  /// Minimum time between quality changes in seconds
  static const int _qualityChangeCooldown = 15;

  /// Network speed threshold multipliers for quality selection
  static const Map<int, double> _qualityThresholds = {
    144: 0.3, // 144p - Very low speed
    240: 0.5, // 240p - Low speed
    360: 1.0, // 360p - Basic speed
    480: 1.8, // 480p - Medium speed
    720: 2.5, // 720p - Good speed
    1080: 4.5, // 1080p - High speed
    1440: 8.0, // 1440p - Very high speed
    2160: 15.0, // 4K - Ultra high speed
  };

  /// Quality change callback
  final ValueNotifier<int> qualityNotifier = ValueNotifier<int>(360);

  /// Network speed callback (in Mbps)
  final ValueNotifier<double> networkSpeedNotifier = ValueNotifier<double>(0.0);

  void _cacheManifest(String videoId, exp.StreamManifest manifest) {
    _manifestCache[videoId] = manifest;
    _manifestCacheOrder.remove(videoId);
    _manifestCacheOrder.add(videoId);
    if (_manifestCacheOrder.length > 20) {
      final oldest = _manifestCacheOrder.removeAt(0);
      _manifestCache.remove(oldest);
    }
  }

  /// Constructs a YPlayerController with optional callback functions.
  YPlayerController({this.onStateChanged, this.onProgressChanged, bool autoQualityEnabled = true}) : statusNotifier = ValueNotifier<YPlayerStatus>(YPlayerStatus.loading), _autoQualityEnabled = autoQualityEnabled {
    _player = Player();
    _setupPlayerListeners();

    // Initialize quality notifier with default 360p
    qualityNotifier.value = 360;

    // Start network monitoring if auto quality is enabled
    if (_autoQualityEnabled) {
      // _startNetworkMonitoring();
    }
  }

  /// Checks if the player has been initialized with media.
  bool get isInitialized => _player.state.playlist.medias.isNotEmpty;

  /// Gets the current status of the player.
  YPlayerStatus get status => _status;

  /// Gets the underlying media_kit Player instance.
  Player get player => _player;

  /// Get the current selected quality
  int get currentQuality => _currentQuality;

  /// Get/Set automatic quality adjustment enabled state
  bool get autoQualityEnabled => _autoQualityEnabled;

  set autoQualityEnabled(bool enabled) {
    _autoQualityEnabled = enabled;
    if (enabled) {
      // _startNetworkMonitoring();
    } else {
      // _stopNetworkMonitoring();
    }
  }

  /// Get current network speed in Mbps
  double get currentNetworkSpeed => networkSpeedNotifier.value;

  /// Get list of available quality options
  List<QualityOption> getAvailableQualities() {
    if (_currentManifest == null) {
      return [];
    }

    // Always include automatic option
    final List<QualityOption> qualities = [QualityOption(height: 0, label: "Auto")];

    // Add available video qualities
    for (var stream in _currentManifest!.videoOnly) {
      // Get height from the videoResolution property
      final height = stream.videoResolution.height;

      // Only add if we don't already have this resolution
      if (height > 0 && !qualities.any((q) => q.height == height)) {
        qualities.add(QualityOption(height: height, label: "${height}p"));
      }
    }

    // Sort by height (highest first, but keep Auto at top)
    qualities.sublist(1).sort((a, b) => b.height.compareTo(a.height));

    return qualities;
  }

  /// Change video quality
  Future<void> setQuality(int height, {bool isAutomatic = false}) async {
    if (_currentManifest == null || _currentVideoId == null) {
      if (!kReleaseMode) {
        debugPrint('YPlayerController: Cannot change quality - no manifest available');
      }
      return;
    }
    if (_status == YPlayerStatus.loading) return;
    if (_currentQuality == height) return; // No-op if already at this quality

    // Check cooldown for automatic changes
    if (isAutomatic && _lastQualityChange != null) {
      final timeSinceLastChange = DateTime.now().difference(_lastQualityChange!).inSeconds;
      if (timeSinceLastChange < _qualityChangeCooldown) {
        return;
      }
    }

    _currentQuality = height;
    _lastQualityChange = DateTime.now();
    qualityNotifier.value = height;

    final currentPosition = _player.state.position;
    final wasPlaying = _player.state.playing;

    _setStatus(YPlayerStatus.loading);
    try {
      exp.VideoStreamInfo videoStreamInfo;
      if (height == 0) {
        videoStreamInfo = _currentManifest!.videoOnly.withHighestBitrate();
      } else {
        videoStreamInfo = _currentManifest!.videoOnly.where((s) => s.videoResolution.height == height).withHighestBitrate();
      }
      final audioStreamInfo = _currentManifest!.audioOnly.withHighestBitrate();

      // Only switch if the URL is different
      final currentUrl = _player.state.playlist.medias.isNotEmpty ? _player.state.playlist.medias.first.uri.toString() : '';
      if (currentUrl == videoStreamInfo.url.toString()) {
        _setStatus(wasPlaying ? YPlayerStatus.playing : YPlayerStatus.paused);
        return;
      }

      if (!kReleaseMode) {
        debugPrint('YPlayerController: ${isAutomatic ? "Auto-changing" : "Changing"} quality to ${videoStreamInfo.videoResolution.height}p');
      }

      await _player.stop();
      await _player.open(Media(videoStreamInfo.url.toString(), start: currentPosition), play: false);
      await Future.delayed(const Duration(milliseconds: 100));
      await _player.setAudioTrack(AudioTrack.uri(audioStreamInfo.url.toString()));

      if (wasPlaying) {
        play();
      }
      _setStatus(wasPlaying ? YPlayerStatus.playing : YPlayerStatus.paused);

      if (!kReleaseMode) {
        debugPrint('YPlayerController: Quality change complete');
      }
    } catch (e) {
      if (!kReleaseMode) {
        debugPrint('YPlayerController: Error changing quality: $e');
      }
      _setStatus(YPlayerStatus.error);
    }
  }

  /// Start network speed monitoring for automatic quality adjustment
  void _startNetworkMonitoring() {
    if (_networkMonitorTimer != null && _networkMonitorTimer!.isActive) {
      return;
    }

    _networkMonitorTimer = Timer.periodic(Duration(seconds: _monitoringInterval), (_) => _monitorNetworkAndAdjustQuality());

    // Initial network check after a short delay
    Future.delayed(Duration(seconds: 2), () => _monitorNetworkAndAdjustQuality());
  }

  /// Stop network speed monitoring
  void _stopNetworkMonitoring() {
    _networkMonitorTimer?.cancel();
    _networkMonitorTimer = null;
  }

  /// Monitor network speed and automatically adjust quality
  Future<void> _monitorNetworkAndAdjustQuality() async {
    if (!_autoQualityEnabled || _currentManifest == null || !isInitialized) {
      return;
    }

    try {
      // Get current video stream for speed test
      final currentVideoStream = _getBestQualityStream(_currentManifest!, _currentQuality);
      final networkSpeed = await _estimateNetworkSpeed(currentVideoStream.url.toString());

      if (networkSpeed == null) return;

      // Convert to Mbps and update notifier
      final speedMbps = networkSpeed / (1024 * 1024);
      networkSpeedNotifier.value = speedMbps;

      // Add to buffer and maintain size
      _networkSpeedBuffer.add(networkSpeed);
      if (_networkSpeedBuffer.length > _maxBufferSize) {
        _networkSpeedBuffer.removeAt(0);
      }

      // Calculate average speed over recent measurements
      final avgSpeed = _networkSpeedBuffer.reduce((a, b) => a + b) / _networkSpeedBuffer.length;
      final avgSpeedMbps = avgSpeed / (1024 * 1024);

      if (!kReleaseMode) {
        debugPrint('YPlayerController: Current speed: ${speedMbps.toStringAsFixed(2)} Mbps, Average: ${avgSpeedMbps.toStringAsFixed(2)} Mbps');
      }

      // Determine optimal quality based on network speed
      final optimalQuality = _calculateOptimalQuality(avgSpeedMbps);

      // Only change quality if it's significantly different and beneficial
      if (_shouldChangeQuality(optimalQuality, avgSpeedMbps)) {
        await setQuality(optimalQuality, isAutomatic: true);

        if (!kReleaseMode) {
          debugPrint('YPlayerController: Auto-adjusted quality to ${optimalQuality}p based on ${avgSpeedMbps.toStringAsFixed(2)} Mbps');
        }
      }
    } catch (e) {
      if (!kReleaseMode) {
        debugPrint('YPlayerController: Error in network monitoring: $e');
      }
    }
  }

  /// Calculate optimal quality based on network speed
  int _calculateOptimalQuality(double speedMbps) {
    final availableQualities = getAvailableQualities().where((q) => q.height > 0).map((q) => q.height).toList()..sort();

    // Find the highest quality that the network can support
    int optimalQuality = 360; // Default fallback

    for (final quality in availableQualities) {
      final requiredSpeed = _qualityThresholds[quality] ?? 2.0;

      // Use 80% of available bandwidth to ensure smooth playback
      if (speedMbps * 0.8 >= requiredSpeed) {
        optimalQuality = quality;
      } else {
        break;
      }
    }

    return optimalQuality;
  }

  /// Determine if quality should be changed based on current conditions
  bool _shouldChangeQuality(int newQuality, double avgSpeedMbps) {
    if (newQuality == _currentQuality) return false;

    // Don't change if we're in a loading state
    if (_status == YPlayerStatus.loading) return false;

    // Check if enough time has passed since last change
    if (_lastQualityChange != null) {
      final timeSinceLastChange = DateTime.now().difference(_lastQualityChange!).inSeconds;
      if (timeSinceLastChange < _qualityChangeCooldown) return false;
    }

    // Only upgrade quality if we have significant bandwidth headroom
    if (newQuality > _currentQuality) {
      final requiredSpeed = _qualityThresholds[newQuality] ?? 2.0;
      return avgSpeedMbps >= requiredSpeed * 1.2; // 20% headroom for upgrades
    }

    // Downgrade more aggressively to prevent buffering
    if (newQuality < _currentQuality) {
      final currentRequiredSpeed = _qualityThresholds[_currentQuality] ?? 2.0;
      return avgSpeedMbps < currentRequiredSpeed * 0.7; // Downgrade if below 70% of required speed
    }

    return false;
  }

  /// Estimate network speed (in bits per second) by downloading a small chunk of the video.
  Future<int?> _estimateNetworkSpeed(String testUrl) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = Duration(seconds: 5);

      final request = await client.getUrl(Uri.parse(testUrl));
      // Download a 1MB chunk for better accuracy
      request.headers.add('Range', 'bytes=0-1048575');

      final stopwatch = Stopwatch()..start();
      final response = await request.close();

      int totalBytes = 0;
      await for (var chunk in response) {
        totalBytes += chunk.length;
      }

      stopwatch.stop();
      client.close();

      if (stopwatch.elapsedMilliseconds == 0 || totalBytes == 0) return null;

      // Calculate bits per second
      final bitsPerSecond = (totalBytes * 8 * 1000 ~/ stopwatch.elapsedMilliseconds);

      if (!kReleaseMode) {
        debugPrint('YPlayerController: Downloaded ${totalBytes} bytes in ${stopwatch.elapsedMilliseconds}ms = ${(bitsPerSecond / (1024 * 1024)).toStringAsFixed(2)} Mbps');
      }

      return bitsPerSecond;
    } catch (e) {
      if (!kReleaseMode) {
        debugPrint('YPlayerController: Network speed test failed: $e');
      }
      return null;
    }
  }

  /// Select the best quality for the estimated network speed.
  Future<int> chooseBestQualityForInternet(exp.StreamManifest manifest) async {
    final videoStreams = manifest.videoOnly.toList();
    if (videoStreams.isEmpty) return 144; // Default to 360p

    // Pick a mid-quality stream for speed test
    final testStream = videoStreams[videoStreams.length ~/ 2];
    final testUrl = testStream.url.toString();
    final estimatedBps = await _estimateNetworkSpeed(testUrl);

    if (estimatedBps == null) return 144; // fallback to 360p

    // Convert to Mbps for easier calculation
    final estimatedMbps = estimatedBps / (1024 * 1024);

    return _calculateOptimalQuality(estimatedMbps);
  }

  /// Helper method to get the best available quality close to target
  exp.VideoStreamInfo _getBestQualityStream(exp.StreamManifest manifest, int targetHeight) {
    final videoStreams = manifest.videoOnly.toList();

    // If target is 0, return highest quality
    if (targetHeight == 0) {
      return videoStreams.withHighestBitrate();
    }

    // Try to find exact match first
    try {
      return videoStreams.where((s) => s.videoResolution.height == targetHeight).withHighestBitrate();
    } catch (e) {
      // If exact match not found, find closest available quality
      videoStreams.sort((a, b) => a.videoResolution.height.compareTo(b.videoResolution.height));

      // Find the closest quality (prefer lower if exact not available)
      exp.VideoStreamInfo? closestStream;
      int smallestDifference = double.maxFinite.toInt();

      for (final stream in videoStreams) {
        final difference = (stream.videoResolution.height - targetHeight).abs();
        if (difference < smallestDifference) {
          smallestDifference = difference;
          closestStream = stream;
        }
      }

      return closestStream ?? videoStreams.withHighestBitrate();
    }
  }

  /// Initializes the player with the given YouTube URL and settings.
  ///
  /// This method fetches video information, extracts stream URLs, and sets up
  /// the player with the optimal quality based on network speed.
  Future<void> initialize(String youtubeUrl, {bool autoPlay = true, double? aspectRatio, bool allowFullScreen = true, bool allowMuting = true, bool chooseBestQuality = true, bool forceOriginalAudio = false, bool enableAutoQuality = true}) async {
    // Update auto quality setting
    _autoQualityEnabled = enableAutoQuality;

    // Avoid re-initialization if the URL hasn't changed
    if (_lastInitializedUrl == youtubeUrl && isInitialized) {
      if (!kReleaseMode) {
        debugPrint('YPlayerController: Already initialized with this URL');
      }
      return;
    }

    _setStatus(YPlayerStatus.loading);
    try {
      // Use cached manifest if available
      exp.StreamManifest manifest;
      String videoId;

      debugPrint('YPlayerController: Fetching video info for $youtubeUrl');
      final video = await _yt.videos.get(youtubeUrl);
      videoId = video.id.value;

      if (_manifestCache.containsKey(videoId)) {
        manifest = _manifestCache[videoId]!;
        // Move to most recently used
        _manifestCacheOrder.remove(videoId);
        _manifestCacheOrder.add(videoId);
      } else {
        // Use iOS client to get better audio track metadata
        manifest = await _yt.videos.streamsClient.getManifest(video.id, ytClients: [exp.YoutubeApiClient.ios, exp.YoutubeApiClient.tv]);
        _cacheManifest(videoId, manifest);
      }

      // Store manifest and video ID for quality changes later
      _currentManifest = manifest;
      _currentVideoId = videoId;

      // Store the force original audio preference
      _forceOriginalAudio = forceOriginalAudio;

      // Choose best quality for internet if requested
      if (chooseBestQuality) {
        final bestQuality = await chooseBestQualityForInternet(manifest);
        _currentQuality = bestQuality;
        qualityNotifier.value = bestQuality;
      }

      // Get the appropriate video stream based on quality setting
      exp.VideoStreamInfo videoStreamInfo = _getBestQualityStream(manifest, _currentQuality);

      // Select audio stream based on forceOriginalAudio setting
      exp.AudioStreamInfo audioStreamInfo;

      if (_forceOriginalAudio) {
        // Try to find the original audio track
        try {
          // First, try to find track with "original" in display name
          audioStreamInfo = manifest.audioOnly.firstWhere((stream) {
            if (stream.audioTrack != null) {
              try {
                dynamic track = stream.audioTrack;
                String displayName = track.displayName?.toString() ?? '';
                return displayName.toLowerCase().contains('original');
              } catch (e) {
                // Fallback to toString() method
                final trackString = stream.audioTrack.toString().toLowerCase();
                return trackString.contains('original');
              }
            }
            return false;
          });
        } catch (e) {
          try {
            // If no "original" track found, try to find non-default track
            audioStreamInfo = manifest.audioOnly.firstWhere((stream) {
              if (stream.audioTrack != null) {
                try {
                  dynamic track = stream.audioTrack;
                  return track.audioIsDefault == false;
                } catch (e) {
                  return false;
                }
              }
              return false;
            });
          } catch (e) {
            // If all else fails, use the first track
            audioStreamInfo = manifest.audioOnly.first;
          }
        }
      } else {
        // Default behavior - use highest bitrate
        audioStreamInfo = manifest.audioOnly.withHighestBitrate();
      }

      if (!kReleaseMode) {
        debugPrint('YPlayerController: Video URL: ${videoStreamInfo.url}');
        debugPrint('YPlayerController: Audio URL: ${audioStreamInfo.url}');
        debugPrint('YPlayerController: Selected quality: ${videoStreamInfo.videoResolution.height}p');
      }

      // Stop any existing playback
      if (isInitialized) {
        debugPrint('YPlayerController: Stopping previous playback');
        await _player.stop();
      }

      // Open the video stream
      await _player.open(Media(videoStreamInfo.url.toString()), play: false);

      // Add the audio track
      await _player.setAudioTrack(AudioTrack.uri(audioStreamInfo.url.toString()));

      // Add a small delay to ensure everything is set up
      await Future.delayed(const Duration(milliseconds: 200));

      // Start playback if autoPlay is true
      if (autoPlay) {
        play();
      }

      _lastInitializedUrl = youtubeUrl;
      _setStatus(autoPlay ? YPlayerStatus.playing : YPlayerStatus.paused);

      // Start network monitoring if enabled
      if (_autoQualityEnabled) {
        // _startNetworkMonitoring();
      }

      if (!kReleaseMode) {
        debugPrint('YPlayerController: Initialization complete. Status: $_status, Auto Quality: $_autoQualityEnabled');
      }
    } catch (e) {
      if (!kReleaseMode) {
        debugPrint('YPlayerController: Error during initialization: $e');
      }
      _setStatus(YPlayerStatus.error);
    }
  }

  /// Sets up listeners for various player events.
  void _setupPlayerListeners() {
    _player.stream.playing.listen((playing) {
      debugPrint('YPlayerController: Playing state changed to $playing');
      _setStatus(playing ? YPlayerStatus.playing : YPlayerStatus.paused);
    });

    _player.stream.completed.listen((completed) {
      debugPrint('YPlayerController: Playback completed: $completed');
      if (completed) {
        _setStatus(YPlayerStatus.stopped);
        // _stopNetworkMonitoring(); // Stop monitoring when playback completes
      }
    });

    _player.stream.position.listen((position) {
      onProgressChanged?.call(position, _player.state.duration);
    });

    _player.stream.error.listen((error) {
      debugPrint('YPlayerController: Error occurred: $error');
      _setStatus(YPlayerStatus.error);
    });

    _player.stream.audioParams.listen((params) {
      debugPrint('YPlayerController: Audio params changed: $params');
    });

    _player.stream.audioDevice.listen((device) {
      debugPrint('YPlayerController: Audio device changed: $device');
    });

    _player.stream.track.listen((track) {
      debugPrint('YPlayerController: Track changed: $track');
    });

    _player.stream.tracks.listen((tracks) {
      debugPrint('YPlayerController: Available tracks: $tracks');
    });
  }

  /// Updates the player status and triggers the onStateChanged callback.
  void _setStatus(YPlayerStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      onStateChanged?.call(_status);
      statusNotifier.value = newStatus;
    }
  }

  /// Starts or resumes video playback.
  Future<void> play() async {
    await _player.play();

    // Resume network monitoring if auto quality is enabled
    if (_autoQualityEnabled && (_networkMonitorTimer == null || !_networkMonitorTimer!.isActive)) {
      // _startNetworkMonitoring();
    }
  }

  /// Set playback speed with debouncing
  Future<void> speed(double speed) async {
    // Debounce rapid speed changes by checking if already set
    if (_player.state.rate == speed) return;
    await _player.setRate(speed);
  }

  /// Pauses video playback.
  Future<void> pause() async {
    await _player.pause();
  }

  /// Stops video playback and resets to the beginning.
  Future<void> stop() async {
    await _player.stop();
    // _stopNetworkMonitoring(); // Stop monitoring when manually stopped
  }

  /// Gets the current playback position.
  Duration get position => _player.state.position;

  /// Gets the total duration of the video.
  Duration get duration => _player.state.duration;

  /// Gets whether original audio is being forced
  bool get forceOriginalAudio => _forceOriginalAudio;

  /// Force a manual network speed check and quality adjustment
  Future<void> checkNetworkAndAdjustQuality() async {
    await _monitorNetworkAndAdjustQuality();
  }

  /// Get quality statistics for debugging
  Map<String, dynamic> getQualityStats() {
    return {'currentQuality': _currentQuality, 'autoQualityEnabled': _autoQualityEnabled, 'networkSpeed': networkSpeedNotifier.value, 'speedBufferSize': _networkSpeedBuffer.length, 'lastQualityChange': _lastQualityChange?.toIso8601String(), 'availableQualities': getAvailableQualities().map((q) => q.label).toList()};
  }

  /// Disposes of all resources used by the controller.
  void dispose() {
    debugPrint('YPlayerController: Disposing');
    // _stopNetworkMonitoring();
    _player.dispose();
    _yt.close();
    statusNotifier.dispose();
    qualityNotifier.dispose();
    networkSpeedNotifier.dispose();
  }
}

////////////////////////////////////////////////////
// import 'dart:io'; // Add for HTTP requests
// import 'dart:math'; // For min/max
//
// import 'package:flutter/foundation.dart'; // For kReleaseMode
// import 'package:media_kit/media_kit.dart';
// import 'package:visual_learning/screen/y_player/y_file/src/types/y_player_progress_callback.dart';
// import 'package:visual_learning/screen/y_player/y_file/src/types/y_player_state_callback.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart' as exp;
//
// import 'enums/y_player_status.dart';
// import 'models/quality_option.dart';
//
// /// Controller for managing the YouTube player.
// ///
// /// This class handles the initialization, playback control, and state management
// /// of the YouTube video player. It uses the youtube_explode_dart package to fetch
// /// video information and the media_kit package for playback.
// class YPlayerController {
//   /// YouTube API client for fetching video information.
//   final exp.YoutubeExplode _yt = exp.YoutubeExplode();
//
//   /// Media player instance from media_kit.
//   late final Player _player;
//
//   /// Current status of the player.
//   YPlayerStatus _status = YPlayerStatus.initial;
//
//   /// Callback function triggered when the player's status changes.
//   final YPlayerStateCallback? onStateChanged;
//
//   /// Callback function triggered when the player's progress changes.
//   final YPlayerProgressCallback? onProgressChanged;
//
//   /// The URL of the last successfully initialized video.
//   String? _lastInitializedUrl;
//
//   /// Store the current manifest for quality changes
//   exp.StreamManifest? _currentManifest;
//
//   /// Store the current video ID
//   String? _currentVideoId;
//
//   /// Current selected quality (resolution height) - Changed default to 720p
//   int _currentQuality = 340; // Changed from 0 to 720 for 720p default
//
//   /// Whether to force the original audio track
//   bool _forceOriginalAudio = false;
//
//   /// Add this ValueNotifier to track status changes
//   final ValueNotifier<YPlayerStatus> statusNotifier;
//
//   /// LRU cache for manifests (max 20 entries)
//   static final Map<String, exp.StreamManifest> _manifestCache = {};
//   static final List<String> _manifestCacheOrder = [];
//
//   void _cacheManifest(String videoId, exp.StreamManifest manifest) {
//     _manifestCache[videoId] = manifest;
//     _manifestCacheOrder.remove(videoId);
//     _manifestCacheOrder.add(videoId);
//     if (_manifestCacheOrder.length > 20) {
//       final oldest = _manifestCacheOrder.removeAt(0);
//       _manifestCache.remove(oldest);
//     }
//   }
//
//   /// Constructs a YPlayerController with optional callback functions.
//   YPlayerController({this.onStateChanged, this.onProgressChanged}) : statusNotifier = ValueNotifier<YPlayerStatus>(YPlayerStatus.loading) {
//     _player = Player();
//     _setupPlayerListeners();
//   }
//
//   /// Checks if the player has been initialized with media.
//   bool get isInitialized => _player.state.playlist.medias.isNotEmpty;
//
//   /// Gets the current status of the player.
//   YPlayerStatus get status => _status;
//
//   /// Gets the underlying media_kit Player instance.
//   Player get player => _player;
//
//   /// Get the current selected quality
//   int get currentQuality => _currentQuality;
//
//   /// Get list of available quality options
//   List<QualityOption> getAvailableQualities() {
//     if (_currentManifest == null) {
//       return [];
//     }
//
//     // Always include automatic option
//     final List<QualityOption> qualities = [QualityOption(height: 0, label: "Auto")];
//
//     // Add available video qualities
//     for (var stream in _currentManifest!.videoOnly) {
//       // Get height from the videoResolution property
//       final height = stream.videoResolution.height;
//
//       // Only add if we don't already have this resolution
//       if (height > 0 && !qualities.any((q) => q.height == height)) {
//         qualities.add(QualityOption(height: height, label: "${height}p"));
//       }
//     }
//
//     // Sort by height (highest first, but keep Auto at top)
//     qualities.sublist(1).sort((a, b) => b.height.compareTo(a.height));
//
//     return qualities;
//   }
//
//   /// Change video quality
//   Future<void> setQuality(int height) async {
//     if (_currentManifest == null || _currentVideoId == null) {
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Cannot change quality - no manifest available');
//       }
//       return;
//     }
//     if (_status == YPlayerStatus.loading) return;
//     if (_currentQuality == height) return; // No-op if already at this quality
//
//     _currentQuality = height;
//     final currentPosition = _player.state.position;
//     final wasPlaying = _player.state.playing;
//
//     _setStatus(YPlayerStatus.loading);
//     try {
//       exp.VideoStreamInfo videoStreamInfo;
//       if (height == 0) {
//         videoStreamInfo = _currentManifest!.videoOnly.withHighestBitrate();
//       } else {
//         videoStreamInfo = _currentManifest!.videoOnly.where((s) => s.videoResolution.height == height).withHighestBitrate();
//       }
//       final audioStreamInfo = _currentManifest!.audioOnly.withHighestBitrate();
//
//       // Only switch if the URL is different
//       final currentUrl = _player.state.playlist.medias.isNotEmpty ? _player.state.playlist.medias.first.uri.toString() : '';
//       if (currentUrl == videoStreamInfo.url.toString()) {
//         _setStatus(wasPlaying ? YPlayerStatus.playing : YPlayerStatus.paused);
//         return;
//       }
//
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Changing quality to ${videoStreamInfo.videoResolution.height}p');
//       }
//       await _player.stop();
//       await _player.open(Media(videoStreamInfo.url.toString(), start: currentPosition), play: false);
//       await Future.delayed(const Duration(milliseconds: 100));
//       await _player.setAudioTrack(AudioTrack.uri(audioStreamInfo.url.toString()));
//       if (wasPlaying) {
//         play();
//       }
//       _setStatus(wasPlaying ? YPlayerStatus.playing : YPlayerStatus.paused);
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Quality change complete');
//       }
//     } catch (e) {
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Error changing quality: $e');
//       }
//       _setStatus(YPlayerStatus.error);
//     }
//   }
//
//   /// Estimate network speed (in bits per second) by downloading a small chunk of the video.
//   Future<int?> _estimateNetworkSpeed(String testUrl) async {
//     try {
//       final client = HttpClient();
//       final request = await client.getUrl(Uri.parse(testUrl));
//       // Only download the first 512KB
//       request.headers.add('Range', 'bytes=0-524287');
//       final stopwatch = Stopwatch()..start();
//       final response = await request.close();
//       int totalBytes = 0;
//       await for (var chunk in response) {
//         totalBytes += chunk.length;
//       }
//       stopwatch.stop();
//       client.close();
//       if (stopwatch.elapsedMilliseconds == 0) return null;
//       // bits per second
//       return (totalBytes * 8 * 1000 ~/ stopwatch.elapsedMilliseconds);
//     } catch (_) {
//       return null;
//     }
//   }
//
//   /// Select the best quality for the estimated network speed.
//   Future<int> chooseBestQualityForInternet(exp.StreamManifest manifest) async {
//     // Use 720p as default instead of highest quality
//     final videoStreams = manifest.videoOnly.toList();
//     if (videoStreams.isEmpty) return 340; // Changed from 0 to 720
//
//     // Pick a mid-quality stream for speed test
//     final testStream = videoStreams[videoStreams.length ~/ 2];
//     final testUrl = testStream.url.toString();
//     final estimatedBps = await _estimateNetworkSpeed(testUrl);
//
//     if (estimatedBps == null) return 340; // fallback to 720p instead of auto
//
//     // Find the highest quality whose bitrate is <= 80% of estimated bandwidth
//     final safeBps = (estimatedBps * 0.8).toInt();
//     videoStreams.sort((a, b) => a.bitrate.compareTo(b.bitrate));
//     int chosenHeight = 340; // Start with 720p as base
//     for (final stream in videoStreams) {
//       if (stream.bitrate.bitsPerSecond <= safeBps) {
//         chosenHeight = max(chosenHeight, stream.videoResolution.height);
//       }
//     }
//     return chosenHeight;
//   }
//
//   /// Helper method to get the best available quality close to target
//   exp.VideoStreamInfo _getBestQualityStream(exp.StreamManifest manifest, int targetHeight) {
//     final videoStreams = manifest.videoOnly.toList();
//
//     // If target is 0, return highest quality
//     if (targetHeight == 0) {
//       return videoStreams.withHighestBitrate();
//     }
//
//     // Try to find exact match first
//     try {
//       return videoStreams.where((s) => s.videoResolution.height == targetHeight).withHighestBitrate();
//     } catch (e) {
//       // If exact match not found, find closest available quality
//       videoStreams.sort((a, b) => a.videoResolution.height.compareTo(b.videoResolution.height));
//
//       // Find the closest quality (prefer lower if exact not available)
//       exp.VideoStreamInfo? closestStream;
//       int smallestDifference = double.maxFinite.toInt();
//
//       for (final stream in videoStreams) {
//         final difference = (stream.videoResolution.height - targetHeight).abs();
//         if (difference < smallestDifference) {
//           smallestDifference = difference;
//           closestStream = stream;
//         }
//       }
//
//       return closestStream ?? videoStreams.withHighestBitrate();
//     }
//   }
//
//   /// Initializes the player with the given YouTube URL and settings.
//   ///
//   /// This method fetches video information, extracts stream URLs, and sets up
//   /// the player with the highest quality video and audio streams available.
//   Future<void> initialize(String youtubeUrl, {bool autoPlay = true, double? aspectRatio, bool allowFullScreen = true, bool allowMuting = true, bool chooseBestQuality = true, bool forceOriginalAudio = false}) async {
//     // Avoid re-initialization if the URL hasn't changed
//     if (_lastInitializedUrl == youtubeUrl && isInitialized) {
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Already initialized with this URL');
//       }
//       return;
//     }
//
//     _setStatus(YPlayerStatus.loading);
//     try {
//       // Use cached manifest if available
//       exp.StreamManifest manifest;
//       String videoId;
//
//       debugPrint('YPlayerController: Fetching video info for $youtubeUrl');
//       final video = await _yt.videos.get(youtubeUrl);
//       videoId = video.id.value;
//
//       if (_manifestCache.containsKey(videoId)) {
//         manifest = _manifestCache[videoId]!;
//         // Move to most recently used
//         _manifestCacheOrder.remove(videoId);
//         _manifestCacheOrder.add(videoId);
//       } else {
//         // Use iOS client to get better audio track metadata
//         manifest = await _yt.videos.streamsClient.getManifest(video.id, ytClients: [exp.YoutubeApiClient.ios, exp.YoutubeApiClient.tv]);
//         _cacheManifest(videoId, manifest);
//       }
//
//       // Store manifest and video ID for quality changes later
//       _currentManifest = manifest;
//       _currentVideoId = videoId;
//
//       // Store the force original audio preference
//       _forceOriginalAudio = forceOriginalAudio;
//
//       // --- Choose best quality for internet if requested ---
//       if (chooseBestQuality) {
//         // Run asynchronously so UI is not blocked
//         Future(() async {
//           final best = await chooseBestQualityForInternet(manifest);
//           if (best != _currentQuality) {
//             _currentQuality = best;
//             await setQuality(best);
//           }
//         });
//       }
//       // -----------------------------------------------------
//
//       // Get the appropriate video stream based on quality setting (now defaults to 720p)
//       exp.VideoStreamInfo videoStreamInfo = _getBestQualityStream(manifest, _currentQuality);
//
//       // Select audio stream based on forceOriginalAudio setting
//       exp.AudioStreamInfo audioStreamInfo;
//
//       if (_forceOriginalAudio) {
//         // Try to find the original audio track
//         try {
//           // First, try to find track with "original" in display name
//           audioStreamInfo = manifest.audioOnly.firstWhere((stream) {
//             if (stream.audioTrack != null) {
//               try {
//                 dynamic track = stream.audioTrack;
//                 String displayName = track.displayName?.toString() ?? '';
//                 return displayName.toLowerCase().contains('original');
//               } catch (e) {
//                 // Fallback to toString() method
//                 final trackString = stream.audioTrack.toString().toLowerCase();
//                 return trackString.contains('original');
//               }
//             }
//             return false;
//           });
//         } catch (e) {
//           try {
//             // If no "original" track found, try to find non-default track
//             // (original tracks are often not the default)
//             audioStreamInfo = manifest.audioOnly.firstWhere((stream) {
//               if (stream.audioTrack != null) {
//                 try {
//                   dynamic track = stream.audioTrack;
//                   return track.audioIsDefault == false;
//                 } catch (e) {
//                   return false;
//                 }
//               }
//               return false;
//             });
//           } catch (e) {
//             // If all else fails, use the first track
//             audioStreamInfo = manifest.audioOnly.first;
//           }
//         }
//       } else {
//         // Default behavior - use highest bitrate
//         audioStreamInfo = manifest.audioOnly.withHighestBitrate();
//       }
//
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Video URL: ${videoStreamInfo.url}');
//         debugPrint('YPlayerController: Audio URL: ${audioStreamInfo.url}');
//         debugPrint('YPlayerController: Selected quality: ${videoStreamInfo.videoResolution.height}p');
//       }
//
//       // Stop any existing playback
//       if (isInitialized) {
//         debugPrint('YPlayerController: Stopping previous playback');
//         await _player.stop();
//       }
//
//       // Open the video stream
//       await _player.open(Media(videoStreamInfo.url.toString()), play: false);
//
//       // Add the audio track
//       await _player.setAudioTrack(AudioTrack.uri(audioStreamInfo.url.toString()));
//
//       // Add a small delay to ensure everything is set up
//       await Future.delayed(const Duration(milliseconds: 200));
//
//       // Start playback if autoPlay is true
//       if (autoPlay) {
//         play();
//       }
//
//       _lastInitializedUrl = youtubeUrl;
//       _setStatus(autoPlay ? YPlayerStatus.playing : YPlayerStatus.paused);
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Initialization complete. Status: $_status');
//       }
//     } catch (e) {
//       if (!kReleaseMode) {
//         debugPrint('YPlayerController: Error during initialization: $e');
//       }
//       _setStatus(YPlayerStatus.error);
//     }
//   }
//
//   /// Sets up listeners for various player events.
//   ///
//   /// This method initializes listeners for playback state changes,
//   /// completion events, position updates, errors, and more.
//   void _setupPlayerListeners() {
//     _player.stream.playing.listen((playing) {
//       debugPrint('YPlayerController: Playing state changed to $playing');
//       _setStatus(playing ? YPlayerStatus.playing : YPlayerStatus.paused);
//     });
//
//     _player.stream.completed.listen((completed) {
//       debugPrint('YPlayerController: Playback completed: $completed');
//       if (completed) _setStatus(YPlayerStatus.stopped);
//     });
//
//     _player.stream.position.listen((position) {
//       debugPrint('YPlayerController: Position updated: $position');
//       onProgressChanged?.call(position, _player.state.duration);
//     });
//
//     _player.stream.error.listen((error) {
//       debugPrint('YPlayerController: Error occurred: $error');
//       _setStatus(YPlayerStatus.error);
//     });
//
//     _player.stream.audioParams.listen((params) {
//       debugPrint('YPlayerController: Audio params changed: $params');
//     });
//
//     _player.stream.audioDevice.listen((device) {
//       debugPrint('YPlayerController: Audio device changed: $device');
//     });
//
//     _player.stream.track.listen((track) {
//       debugPrint('YPlayerController: Track changed: $track');
//     });
//
//     _player.stream.tracks.listen((tracks) {
//       debugPrint('YPlayerController: Available tracks: $tracks');
//     });
//   }
//
//   /// Updates the player status and triggers the onStateChanged callback.
//   void _setStatus(YPlayerStatus newStatus) {
//     if (_status != newStatus) {
//       _status = newStatus;
//       // Remove or comment out debugPrints in production for performance
//       // debugPrint('YPlayerController: Status changed to $newStatus');
//       onStateChanged?.call(_status);
//       statusNotifier.value = newStatus;
//     }
//   }
//
//   /// Starts or resumes video playback.
//   Future<void> play() async {
//     // Remove or comment out debugPrints in production for performance
//     // debugPrint('YPlayerController: Play requested');
//     await _player.play();
//   }
//
//   Future<void> speed(double speed) async {
//     // Debounce rapid speed changes by checking if already set
//     if (_player.state.rate == speed) return;
//     await _player.setRate(speed);
//   }
//
//   /// Pauses video playback.
//   Future<void> pause() async {
//     // debugPrint('YPlayerController: Pause requested');
//     await _player.pause();
//   }
//
//   /// Stops video playback and resets to the beginning.
//   Future<void> stop() async {
//     // debugPrint('YPlayerController: Stop requested');
//     await _player.stop();
//   }
//
//   /// Enables background audio playback when screen is closed
//
//   /// Gets the current playback position.
//   Duration get position => _player.state.position;
//
//   /// Gets the total duration of the video.
//   Duration get duration => _player.state.duration;
//
//   /// Gets whether original audio is being forced
//   bool get forceOriginalAudio => _forceOriginalAudio;
//
//   /// Disposes of all resources used by the controller.
//   void dispose() {
//     debugPrint('YPlayerController: Disposing');
//     _player.dispose();
//     _yt.close();
//   }
// }
