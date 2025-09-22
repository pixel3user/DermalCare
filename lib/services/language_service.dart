import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage {
  english,
  chinese,
}

class LanguageService extends ChangeNotifier {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  AppLanguage _currentLanguage = AppLanguage.english;
  bool _isInitialized = false;

  AppLanguage get currentLanguage => _currentLanguage;
  bool get isInitialized => _isInitialized;
  
  String get currentLanguageCode => _currentLanguage == AppLanguage.english ? 'EN' : 'CN';
  String get currentLanguageName => _currentLanguage == AppLanguage.english ? 'English' : '中文';
  Locale get currentLocale => _currentLanguage == AppLanguage.english 
      ? const Locale('en', '') 
      : const Locale('zh', 'CN');

  // Chinese-speaking countries/regions
  static const List<String> chineseSpeakingRegions = [
    'CN', // China
    'TW', // Taiwan
    'HK', // Hong Kong
    'MO', // Macau
    'SG', // Singapore (has significant Chinese population)
  ];

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // First, try to get saved language preference
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('app_language');
      
      if (savedLanguage != null) {
        _currentLanguage = savedLanguage == 'chinese' 
            ? AppLanguage.chinese 
            : AppLanguage.english;
      } else {
        // If no saved preference, detect based on location
        await _detectLanguageFromLocation();
      }
      
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing language service: $e');
      // Default to English if anything fails
      _currentLanguage = AppLanguage.english;
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> _detectLanguageFromLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        _currentLanguage = AppLanguage.english;
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          _currentLanguage = AppLanguage.english;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
        _currentLanguage = AppLanguage.english;
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );

      // Get country code from coordinates
      String? countryCode = await _getCountryCodeFromCoordinates(
        position.latitude, 
        position.longitude
      );

      if (countryCode != null && chineseSpeakingRegions.contains(countryCode)) {
        _currentLanguage = AppLanguage.chinese;
      } else {
        _currentLanguage = AppLanguage.english;
      }

      print('Detected country: $countryCode, Language: ${_currentLanguage.name}');
    } catch (e) {
      print('Error detecting location: $e');
      _currentLanguage = AppLanguage.english;
    }
  }

  Future<String?> _getCountryCodeFromCoordinates(double lat, double lng) async {
    try {
      // Using a free reverse geocoding service
      final response = await http.get(
        Uri.parse('https://api.bigdatacloud.net/data/reverse-geocode-client?'
            'latitude=$lat&longitude=$lng&localityLanguage=en'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['countryCode'] as String?;
      }
    } catch (e) {
      print('Error getting country code: $e');
    }
    return null;
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (_currentLanguage == language) return;
    
    _currentLanguage = language;
    
    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', language.name);
    
    notifyListeners();
  }

  void toggleLanguage() {
    final newLanguage = _currentLanguage == AppLanguage.english 
        ? AppLanguage.chinese 
        : AppLanguage.english;
    setLanguage(newLanguage);
  }

  // Helper method to get translated text
  String getText(String englishText, String chineseText) {
    return _currentLanguage == AppLanguage.english ? englishText : chineseText;
  }
}
