import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoCacheManager {
  static final VideoCacheManager _instance = VideoCacheManager._internal();
  factory VideoCacheManager() => _instance;
  VideoCacheManager._internal();

  static const String _cacheKey = 'video_cache_info';
  static const int _maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration _cacheExpiry = Duration(days: 7);

  Future<String?> getCachedVideoPath(String videoPath) async {
    if (kIsWeb) return null; // No caching on web
    
    try {
      final cacheInfo = await _getCacheInfo();
      final videoKey = _getVideoKey(videoPath);
      
      if (cacheInfo.containsKey(videoKey)) {
        final cacheData = cacheInfo[videoKey];
        final cacheTime = DateTime.fromMillisecondsSinceEpoch(cacheData['timestamp']);
        
        // Check if cache is still valid
        if (DateTime.now().difference(cacheTime) < _cacheExpiry) {
          final cachedPath = cacheData['path'] as String;
          final file = File(cachedPath);
          
          if (await file.exists()) {
            return cachedPath;
          } else {
            // Remove invalid cache entry
            cacheInfo.remove(videoKey);
            await _saveCacheInfo(cacheInfo);
          }
        } else {
          // Remove expired cache entry
          cacheInfo.remove(videoKey);
          await _saveCacheInfo(cacheInfo);
        }
      }
    } catch (e) {
      print('Error checking video cache: $e');
    }
    
    return null;
  }

  Future<String?> cacheVideo(String videoPath) async {
    if (kIsWeb) return null; // No caching on web
    
    try {
      final cacheDir = await getApplicationCacheDirectory();
      final videoCacheDir = Directory('${cacheDir.path}/videos');
      
      if (!await videoCacheDir.exists()) {
        await videoCacheDir.create(recursive: true);
      }
      
      final videoKey = _getVideoKey(videoPath);
      final cachedPath = '${videoCacheDir.path}/$videoKey.mp4';
      
      // Check if already cached
      final existingFile = File(cachedPath);
      if (await existingFile.exists()) {
        await _updateCacheInfo(videoKey, cachedPath);
        return cachedPath;
      }
      
      // Copy video to cache
      final sourceFile = File(videoPath);
      if (await sourceFile.exists()) {
        await sourceFile.copy(cachedPath);
        await _updateCacheInfo(videoKey, cachedPath);
        await _cleanupOldCache();
        return cachedPath;
      }
    } catch (e) {
      print('Error caching video: $e');
    }
    
    return null;
  }

  Future<void> clearCache() async {
    if (kIsWeb) return;
    
    try {
      final cacheDir = await getApplicationCacheDirectory();
      final videoCacheDir = Directory('${cacheDir.path}/videos');
      
      if (await videoCacheDir.exists()) {
        await videoCacheDir.delete(recursive: true);
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
    } catch (e) {
      print('Error clearing video cache: $e');
    }
  }

  Future<int> getCacheSize() async {
    if (kIsWeb) return 0;
    
    try {
      final cacheDir = await getApplicationCacheDirectory();
      final videoCacheDir = Directory('${cacheDir.path}/videos');
      
      if (!await videoCacheDir.exists()) return 0;
      
      int totalSize = 0;
      await for (final entity in videoCacheDir.list(recursive: true)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
      
      return totalSize;
    } catch (e) {
      print('Error calculating cache size: $e');
      return 0;
    }
  }

  String _getVideoKey(String videoPath) {
    return videoPath.hashCode.toString();
  }

  Future<Map<String, dynamic>> _getCacheInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheInfoString = prefs.getString(_cacheKey);
      
      if (cacheInfoString != null) {
        return Map<String, dynamic>.from(
          Uri.splitQueryString(cacheInfoString)
        );
      }
    } catch (e) {
      print('Error getting cache info: $e');
    }
    
    return {};
  }

  Future<void> _saveCacheInfo(Map<String, dynamic> cacheInfo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheInfoString = Uri(queryParameters: cacheInfo.map(
        (key, value) => MapEntry(key, value.toString())
      )).query;
      
      await prefs.setString(_cacheKey, cacheInfoString);
    } catch (e) {
      print('Error saving cache info: $e');
    }
  }

  Future<void> _updateCacheInfo(String videoKey, String cachedPath) async {
    final cacheInfo = await _getCacheInfo();
    cacheInfo[videoKey] = {
      'path': cachedPath,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    await _saveCacheInfo(cacheInfo);
  }

  Future<void> _cleanupOldCache() async {
    try {
      final cacheSize = await getCacheSize();
      if (cacheSize > _maxCacheSize) {
        final cacheInfo = await _getCacheInfo();
        final sortedEntries = cacheInfo.entries.toList()
          ..sort((a, b) {
            final timestampA = a.value['timestamp'] as int;
            final timestampB = b.value['timestamp'] as int;
            return timestampA.compareTo(timestampB);
          });
        
        // Remove oldest entries until under limit
        for (final entry in sortedEntries) {
          final file = File(entry.value['path'] as String);
          if (await file.exists()) {
            await file.delete();
          }
          cacheInfo.remove(entry.key);
          
          final newSize = await getCacheSize();
          if (newSize <= _maxCacheSize * 0.8) break; // Leave some buffer
        }
        
        await _saveCacheInfo(cacheInfo);
      }
    } catch (e) {
      print('Error cleaning up cache: $e');
    }
  }
}
