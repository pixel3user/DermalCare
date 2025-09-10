import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoPreloader {
  static final VideoPreloader _instance = VideoPreloader._internal();
  factory VideoPreloader() => _instance;
  VideoPreloader._internal();

  final Map<String, VideoPlayerController> _preloadedVideos = {};
  final Map<String, bool> _preloadingStatus = {};

  Future<VideoPlayerController?> preloadVideo(String path, {bool isNetwork = false}) async {
    print('🎬 Preloading video: $path (isNetwork: $isNetwork)');
    
    if (_preloadedVideos.containsKey(path)) {
      print('🎬 Video already preloaded: $path');
      return _preloadedVideos[path];
    }

    if (_preloadingStatus[path] == true) {
      print('🎬 Video is currently being preloaded, waiting...');
      // Wait for ongoing preload to complete
      while (_preloadingStatus[path] == true) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      return _preloadedVideos[path];
    }

    _preloadingStatus[path] = true;

    try {
      VideoPlayerController controller;
      
      if (isNetwork) {
        print('🎬 Creating network video controller');
        controller = VideoPlayerController.networkUrl(Uri.parse(path));
      } else {
        print('🎬 Creating asset video controller');
        controller = VideoPlayerController.asset(path);
      }

      print('🎬 Initializing video controller...');
      await controller.initialize();
      print('🎬 Video controller initialized successfully');
      
      _preloadedVideos[path] = controller;
      
      return controller;
    } catch (e) {
      print('❌ Error preloading video $path: $e');
      print('❌ Error type: ${e.runtimeType}');
      return null;
    } finally {
      _preloadingStatus[path] = false;
    }
  }

  VideoPlayerController? getPreloadedVideo(String path) {
    return _preloadedVideos[path];
  }

  bool isPreloaded(String path) {
    return _preloadedVideos.containsKey(path);
  }

  Future<void> disposeVideo(String path) async {
    final controller = _preloadedVideos.remove(path);
    if (controller != null) {
      await controller.dispose();
    }
    _preloadingStatus.remove(path);
  }

  Future<void> disposeAll() async {
    for (final controller in _preloadedVideos.values) {
      await controller.dispose();
    }
    _preloadedVideos.clear();
    _preloadingStatus.clear();
  }

  int get preloadedCount => _preloadedVideos.length;
}
