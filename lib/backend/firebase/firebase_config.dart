import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC6ZhJrijz9KtGHHjRUrdrcoyncoLreR7Y",
            authDomain: "dermalcare-69.firebaseapp.com",
            projectId: "dermalcare-69",
            storageBucket: "dermalcare-69.firebasestorage.app",
            messagingSenderId: "143419068550",
            appId: "1:143419068550:web:ee2fd85efc1472e2464107",
            measurementId: "G-KFZ6T1C427"));
  } else {
    await Firebase.initializeApp();
  }
}
