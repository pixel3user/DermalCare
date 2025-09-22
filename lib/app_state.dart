import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/language_service.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _authTokenState = prefs.getString('ff_authTokenState') ?? _authTokenState;
    });
    
    // Initialize language service
    await LanguageService().initialize();
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _chatboxResponse = '';
  String get chatboxResponse => _chatboxResponse;
  set chatboxResponse(String value) {
    _chatboxResponse = value;
  }

  String _chatboxText = '';
  String get chatboxText => _chatboxText;
  set chatboxText(String value) {
    _chatboxText = value;
  }

  String _authTokenState = '';
  String get authTokenState => _authTokenState;
  set authTokenState(String value) {
    _authTokenState = value;
    prefs.setString('ff_authTokenState', value);
  }

  dynamic _cart;
  dynamic get cart => _cart;
  set cart(dynamic value) {
    _cart = value;
  }

  List<dynamic> _chatHistory = [];
  List<dynamic> get chatHistory => _chatHistory;
  set chatHistory(List<dynamic> value) {
    _chatHistory = value;
  }

  void addToChatHistory(dynamic value) {
    chatHistory.add(value);
  }

  void removeFromChatHistory(dynamic value) {
    chatHistory.remove(value);
  }

  void removeAtIndexFromChatHistory(int index) {
    chatHistory.removeAt(index);
  }

  void updateChatHistoryAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    chatHistory[index] = updateFn(_chatHistory[index]);
  }

  void insertAtIndexInChatHistory(int index, dynamic value) {
    chatHistory.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
