import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart' show routeObserver;
import '/flutter_flow/video_cache_manager.dart';
import '/flutter_flow/video_preloader.dart';
import '/flutter_flow/video_format_validator.dart';

const kDefaultAspectRatio = 16 / 9;

enum VideoType {
  asset,
  network,
}

Set<VideoPlayerController> _videoPlayers = Set();

class FlutterFlowVideoPlayer extends StatefulWidget {
  const FlutterFlowVideoPlayer({
    super.key,
    required this.path,
    this.videoType = VideoType.network,
    this.width,
    this.height,
    this.aspectRatio,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowPlaybackSpeedMenu = false,
    this.lazyLoad = false,
    this.pauseOnNavigate = true,
  });

  final String path;
  final VideoType videoType;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedMenu;
  final bool lazyLoad;
  final bool pauseOnNavigate;

  @override
  State<StatefulWidget> createState() => _FlutterFlowVideoPlayerState();
}

class _FlutterFlowVideoPlayerState extends State<FlutterFlowVideoPlayer>
    with RouteAware {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _loggedError = false;
  bool _subscribedRoute = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    if (_subscribedRoute) {
      routeObserver.unsubscribe(this);
    }
    _disposeCurrentPlayer();
    super.dispose();
  }

  @override
  void didUpdateWidget(FlutterFlowVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _disposeCurrentPlayer();
      _initializePlayer();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
      _subscribedRoute = true;
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
  }

  @override
  void didPushNext() {
    if (widget.pauseOnNavigate) {
      _videoPlayerController?.pause();
    }
  }

  double get width => widget.width == null || widget.width! >= double.infinity
      ? MediaQuery.sizeOf(context).width
      : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
          ? width / aspectRatio
          : widget.height!;

  double get aspectRatio =>
      _chewieController?.videoPlayerController.value.aspectRatio ??
      kDefaultAspectRatio;

  void _disposeCurrentPlayer() {
    _videoPlayers.remove(_videoPlayerController);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  Future _initializePlayer() async {
    try {
      print('🎥 Initializing video player for: ${widget.path}');
      
      // Validate video format first
      final videoInfo = VideoFormatValidator.getVideoInfo(widget.path);
      print('🎥 Video info: $videoInfo');
      
      if (!videoInfo['isSupported']) {
        print('❌ Unsupported video format: ${videoInfo['extension']}');
        print('💡 Suggestion: ${VideoFormatValidator.getOptimizationSuggestion(widget.path)}');
        _loggedError = true;
        if (mounted) setState(() {});
        return;
      }
      
      print('✅ Video format is supported');

      // Try to get preloaded controller first
      _videoPlayerController = VideoPreloader().getPreloadedVideo(widget.path);
      
      if (_videoPlayerController == null) {
        print('🎥 Creating new video controller');
        // If not preloaded, create new controller
        _videoPlayerController = widget.videoType == VideoType.network
            ? VideoPlayerController.networkUrl(Uri.parse(widget.path))
            : VideoPlayerController.asset(widget.path);
        print('🎥 Video controller created: ${_videoPlayerController.runtimeType}');
      } else {
        print('🎥 Using preloaded video controller');
      }
      
      if (kIsWeb && widget.autoPlay) {
        // Browsers generally don't allow autoplay unless it's muted.
        // Ideally this should be configurable, but for now we just automatically
        // mute on web.
        // See https://pub.dev/packages/video_player_web#autoplay
        _videoPlayerController!.setVolume(0);
      }
      
      if (!widget.lazyLoad) {
        print('🎥 Initializing video controller...');
        await _videoPlayerController?.initialize();
        print('🎥 Video controller initialized: ${_videoPlayerController?.value.isInitialized}');
      }
      
      print('🎥 Creating Chewie controller...');
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        showControls: widget.showControls,
        allowFullScreen: widget.allowFullScreen,
        allowPlaybackSpeedChanging: widget.allowPlaybackSpeedMenu,
        // Add error handling
        errorBuilder: (context, errorMessage) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Video playback error',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please try again later',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      );

      _videoPlayers.add(_videoPlayerController!);
      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.hasError && !_loggedError) {
          print(
              'Error playing video: ${_videoPlayerController!.value.errorDescription}');
          _loggedError = true;
          // Trigger rebuild to show error state
          if (mounted) {
            setState(() {});
          }
        }
        // Stop all other players when one video is playing.
        if (_videoPlayerController!.value.isPlaying) {
          _videoPlayers.forEach((otherPlayer) {
            if (otherPlayer != _videoPlayerController &&
                otherPlayer.value.isPlaying &&
                mounted) {
              setState(() {
                otherPlayer.pause();
              });
            }
          });
        }
      });
    } catch (e) {
      print('❌ Failed to initialize video player: $e');
      print('❌ Error type: ${e.runtimeType}');
      _loggedError = true;
      if (mounted) {
        setState(() {});
      }
    }

    _chewieController!.addListener(() {
      // On web, Chewie has issues when exiting fullscreen. As a workaround,
      // reset the video player when exiting fullscreen, as suggested here:
      // https://github.com/fluttercommunity/chewie/issues/688#issuecomment-1790033300.
      if (kIsWeb && !_chewieController!.isFullScreen && _isFullScreen) {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          final position = _videoPlayerController!.value.position;
          _disposeCurrentPlayer();
          await _initializePlayer();
          _videoPlayerController!.seekTo(position);
        });
      }
      _isFullScreen = _chewieController!.isFullScreen;
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.cover,
        child: Container(
          height: height,
          width: width,
          child: _loggedError
              ? Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.white, size: 48),
                        SizedBox(height: 16),
                        Text(
                          'Video unavailable',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please check your connection',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              : _chewieController != null &&
                      (widget.lazyLoad ||
                          _chewieController!
                              .videoPlayerController.value.isInitialized)
                  ? Chewie(controller: _chewieController!)
                  : (_chewieController != null &&
                          _chewieController!.videoPlayerController.value.hasError)
                      ? Container(
                          color: Colors.black,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline, color: Colors.white, size: 48),
                                SizedBox(height: 16),
                                Text(
                                  'Video playback error',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Please try again later',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text('Loading'),
                          ],
                        ),
        ),
      );
}
