import '/flutter_flow/flutter_flow_util.dart';
import 'base_input_field_widget.dart' show BaseInputFieldWidget;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class BaseInputFieldModel extends FlutterFlowModel<BaseInputFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadDataPath = false;
  FFUploadedFile uploadedLocalFile_uploadDataPath =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataPath = '';

  // Speech recognition fields
  SpeechToText? speechToText;
  bool isListening = false;
  bool isSpeechAvailable = false;
  String lastWords = '';
  
  // Check if browser supports speech recognition
  bool get isBrowserSupported {
    if (!kIsWeb) return true;
    
    // Check for speech recognition support
    return true; // Let the speech_to_text plugin handle browser detection
  }

  // Test if speech recognition actually works on web
  Future<bool> testWebSpeechRecognition() async {
    if (!kIsWeb) return true;
    
    try {
      // Try a very short test to see if speech recognition works
      await speechToText!.listen(
        onResult: (result) {
          print('Test speech result: ${result.recognizedWords}');
        },
        listenFor: Duration(milliseconds: 100),
        partialResults: false,
      );
      await speechToText!.stop();
      return true;
    } catch (e) {
      print('Web speech test failed: $e');
      return false;
    }
  }

  // Alternative approach: just assume it works if initialization succeeded
  Future<bool> assumeWebSpeechWorks() async {
    if (!kIsWeb) return true;
    
    // If we got this far, the browser probably supports speech recognition
    // The actual test will happen when the user tries to speak
    return true;
  }

  @override
  void initState(BuildContext context) {
    // Initialize speech recognition after a short delay to ensure proper setup
    Future.delayed(Duration(milliseconds: 500), () {
      initSpeech();
    });
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  // Check and request microphone permission
  Future<bool> checkMicrophonePermission() async {
    // Skip permission check on web platform
    if (kIsWeb) {
      print('Web platform detected - skipping permission check');
      return true;
    }
    
    try {
      var status = await Permission.microphone.status;
      print('Current microphone permission status: $status');
      
      if (status.isDenied) {
        print('Requesting microphone permission...');
        status = await Permission.microphone.request();
        print('Permission request result: $status');
      } else if (status.isPermanentlyDenied) {
        print('Microphone permission permanently denied');
        return false;
      }
      
      return status.isGranted;
    } catch (e) {
      print('Permission check failed: $e');
      return false;
    }
  }

  // Request microphone permission with user feedback
  Future<bool> requestMicrophonePermission() async {
    print('Starting microphone permission request...');
    
    // Skip permission request on web platform
    if (kIsWeb) {
      print('Web platform detected - assuming permission granted');
      return true;
    }
    
    try {
      // Check current status
      var status = await Permission.microphone.status;
      print('Initial permission status: $status');
      
      if (status.isGranted) {
        print('Permission already granted');
        return true;
      }
      
      if (status.isPermanentlyDenied) {
        print('Permission permanently denied - user needs to go to settings');
        return false;
      }
      
      // Request permission
      print('Requesting microphone permission...');
      status = await Permission.microphone.request();
      print('Permission request completed with status: $status');
      
      return status.isGranted;
    } catch (e) {
      print('Permission request failed: $e');
      return false;
    }
  }

  // Initialize speech recognition
  Future<void> initSpeech() async {
    speechToText = SpeechToText();
    try {
      // For web platform, skip permission check and try direct initialization
      if (kIsWeb) {
        print('Web platform detected - initializing speech recognition directly');
        
        // Try to initialize with minimal configuration for web
        bool available = await speechToText!.initialize(
          onError: (errorNotification) {
            print('Speech recognition error: ${errorNotification.errorMsg}');
            isSpeechAvailable = false;
          },
          onStatus: (status) {
            print('Speech recognition status: $status');
            if (status == 'done' || status == 'notListening') {
              isListening = false;
            }
          },
        );
        
        if (available) {
          // For web, test if speech recognition actually works
          print('Speech recognition initialization successful on web');
          
          // Try to get locales for debugging, but don't fail if empty
          try {
            List<LocaleName> locales = await speechToText!.locales();
            print('Available locales: $locales');
          } catch (e) {
            print('Could not get locales: $e');
          }
          
          // For web, if initialization succeeded, assume it works
          // The real test will be when the user actually tries to speak
          isSpeechAvailable = await assumeWebSpeechWorks();
          print('Web speech recognition assumed available: $isSpeechAvailable');
        } else {
          isSpeechAvailable = false;
        }
      } else {
        // For mobile platforms, request permission first
        bool hasPermission = await requestMicrophonePermission();
        
        if (!hasPermission) {
          print('Microphone permission denied or not available');
          isSpeechAvailable = false;
          return;
        }

        // Check if speech recognition is available
        bool available = await speechToText!.initialize(
          onError: (errorNotification) {
            print('Speech recognition error: ${errorNotification.errorMsg}');
            isSpeechAvailable = false;
          },
          onStatus: (status) {
            print('Speech recognition status: $status');
          },
        );
        
        // Check if the device has speech recognition capabilities
        if (available) {
          List<LocaleName> locales = await speechToText!.locales();
          print('Available locales: $locales');
          isSpeechAvailable = locales.isNotEmpty;
        } else {
          isSpeechAvailable = false;
        }
      }
      
      print('Speech recognition available: $isSpeechAvailable');
    } catch (e) {
      print('Error initializing speech recognition: $e');
      isSpeechAvailable = false;
    }
  }

  // Start listening for speech
  void startListening() async {
    if (!isSpeechAvailable) {
      // Try to reinitialize if not available
      await initSpeech();
    }
    
    if (isSpeechAvailable && !isListening) {
      try {
        // Clear previous text when starting new speech recognition
        if (textController != null) {
          textController!.clear();
        }
        // For web, use simpler configuration
        if (kIsWeb) {
          await speechToText!.listen(
            onResult: (result) {
              lastWords = result.recognizedWords;
              print('Web speech result: ${result.recognizedWords}');
              
              // Update text controller with partial results for better UX
              if (textController != null && result.recognizedWords.isNotEmpty) {
                textController!.text = result.recognizedWords;
              }
              
              if (result.finalResult) {
                // Ensure final result is set
                if (textController != null && result.recognizedWords.isNotEmpty) {
                  textController!.text = result.recognizedWords;
                }
                // Don't automatically stop listening - let user control it
                print('Final speech result: ${result.recognizedWords}');
              }
            },
            listenFor: Duration(seconds: 30),
            pauseFor: Duration(seconds: 3),
            partialResults: true,
            cancelOnError: true,
          );
        } else {
          // For mobile, use full configuration
          await speechToText!.listen(
            onResult: (result) {
              lastWords = result.recognizedWords;
              
              // Update text controller with partial results for better UX
              if (textController != null && result.recognizedWords.isNotEmpty) {
                textController!.text = result.recognizedWords;
              }
              
              if (result.finalResult) {
                // Ensure final result is set
                if (textController != null && result.recognizedWords.isNotEmpty) {
                  textController!.text = result.recognizedWords;
                }
                // Don't automatically stop listening - let user control it
                print('Final speech result: ${result.recognizedWords}');
              }
            },
            listenFor: Duration(seconds: 30),
            pauseFor: Duration(seconds: 3),
            partialResults: true,
            localeId: 'en_US',
            onSoundLevelChange: (level) {
              // Optional: handle sound level changes
            },
            cancelOnError: true,
            listenMode: ListenMode.confirmation,
          );
        }
        isListening = true;
      } catch (e) {
        print('Error starting speech recognition: $e');
        isListening = false;
        isSpeechAvailable = false;
      }
    }
  }

  // Stop listening for speech
  void stopListening() async {
    if (isListening) {
      try {
        await speechToText!.stop();
        isListening = false;
        print('Speech recognition stopped');
        
      } catch (e) {
        print('Error stopping speech recognition: $e');
        isListening = false;
      }
    }
  }

  // Toggle speech recognition
  void toggleListening() {
    if (isListening) {
      stopListening();
    } else {
      startListening();
    }
  }
}
