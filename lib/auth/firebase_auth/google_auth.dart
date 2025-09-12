import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _googleSignIn = GoogleSignIn(
  scopes: ['profile', 'email'],
  // Use serverClientId for Android (web client ID from google-services.json)
  serverClientId: kIsWeb ? null : '143419068550-1vl1djl2nq751n6sjsc21jurrcs16bf6.apps.googleusercontent.com',
);

Future<UserCredential?> googleSignInFunc() async {
  try {
    print('🎯 Starting Google Sign-In...');
    
    if (kIsWeb) {
      print('🌐 Web platform detected');
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
    }

    print('📱 Mobile platform detected');
    await signOutWithGoogle().catchError((_) => null);
    
    print('🔐 Initiating Google Sign-In...');
    final googleUser = await _googleSignIn.signIn();
    
    if (googleUser == null) {
      print('❌ Google Sign-In cancelled by user');
      return null;
    }
    
    print('✅ Google Sign-In successful, getting authentication...');
    final auth = await googleUser.authentication;
    
    if (auth == null) {
      print('❌ Failed to get authentication from Google');
      return null;
    }
    
    print('🔑 Creating Firebase credential...');
    final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken, accessToken: auth.accessToken);
    
    print('🔥 Signing in with Firebase...');
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    
    print('🎉 Google Sign-In completed successfully: ${userCredential.user?.uid}');
    return userCredential;
  } catch (e) {
    print('❌ Google Sign-In error: $e');
    print('❌ Error type: ${e.runtimeType}');
    rethrow;
  }
}

Future signOutWithGoogle() => _googleSignIn.signOut();
