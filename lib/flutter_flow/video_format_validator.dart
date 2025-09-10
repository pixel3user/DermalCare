import 'package:flutter/foundation.dart';

class VideoFormatValidator {
  static const List<String> _supportedFormats = [
    'mp4',
    'mov',
    'avi',
    'mkv',
    'webm',
    '3gp',
    'flv',
  ];

  static const List<String> _preferredFormats = [
    'mp4', // Most compatible format
    'webm', // Good for web
    'mov', // iOS compatible
  ];

  static bool isSupportedFormat(String videoPath) {
    final extension = _getFileExtension(videoPath).toLowerCase();
    return _supportedFormats.contains(extension);
  }

  static bool isPreferredFormat(String videoPath) {
    final extension = _getFileExtension(videoPath).toLowerCase();
    return _preferredFormats.contains(extension);
  }

  static String getRecommendedFormat() {
    if (kIsWeb) {
      return 'webm';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'mov';
    } else {
      return 'mp4';
    }
  }

  static List<String> getSupportedFormats() {
    if (kIsWeb) {
      return ['webm', 'mp4'];
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return ['mov', 'mp4'];
    } else {
      return ['mp4', 'avi', 'mkv', 'webm'];
    }
  }

  static String _getFileExtension(String path) {
    final lastDot = path.lastIndexOf('.');
    if (lastDot == -1 || lastDot == path.length - 1) {
      return '';
    }
    return path.substring(lastDot + 1);
  }

  static Map<String, dynamic> getVideoInfo(String videoPath) {
    final extension = _getFileExtension(videoPath).toLowerCase();
    
    return {
      'path': videoPath,
      'extension': extension,
      'isSupported': isSupportedFormat(videoPath),
      'isPreferred': isPreferredFormat(videoPath),
      'recommendedFormat': getRecommendedFormat(),
      'platform': kIsWeb ? 'web' : defaultTargetPlatform.name,
    };
  }

  static String getOptimizationSuggestion(String videoPath) {
    final info = getVideoInfo(videoPath);
    
    if (!info['isSupported']) {
      return 'Video format ${info['extension']} is not supported. '
             'Please convert to ${info['recommendedFormat']} format.';
    }
    
    if (!info['isPreferred']) {
      return 'Video format ${info['extension']} may cause compatibility issues. '
             'Consider converting to ${info['recommendedFormat']} for better performance.';
    }
    
    return 'Video format is optimal for ${info['platform']} platform.';
  }
}
