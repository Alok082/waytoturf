// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCzRuO85m_Bct81CBhDX8HSePsdCvfEa0Q',
    appId: '1:807803753641:web:20a344c69b9724b674c5b8',
    messagingSenderId: '807803753641',
    projectId: 'waytoturf-8af8e',
    authDomain: 'waytoturf-8af8e.firebaseapp.com',
    storageBucket: 'waytoturf-8af8e.appspot.com',
    measurementId: 'G-MELD02XDC0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_XYanjzhfMduADbzV86mR5ynf09fhhwY',
    appId: '1:807803753641:android:c0bacec0e290dc5f74c5b8',
    messagingSenderId: '807803753641',
    projectId: 'waytoturf-8af8e',
    storageBucket: 'waytoturf-8af8e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHavDA5XLPtDQjGg0HRoUnb7SsR9K-gyo',
    appId: '1:807803753641:ios:55a0e1d35975c6fe74c5b8',
    messagingSenderId: '807803753641',
    projectId: 'waytoturf-8af8e',
    storageBucket: 'waytoturf-8af8e.appspot.com',
    iosBundleId: 'com.example.waytoturf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHavDA5XLPtDQjGg0HRoUnb7SsR9K-gyo',
    appId: '1:807803753641:ios:55a0e1d35975c6fe74c5b8',
    messagingSenderId: '807803753641',
    projectId: 'waytoturf-8af8e',
    storageBucket: 'waytoturf-8af8e.appspot.com',
    iosBundleId: 'com.example.waytoturf',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCzRuO85m_Bct81CBhDX8HSePsdCvfEa0Q',
    appId: '1:807803753641:web:fe6a76c7aac63d4674c5b8',
    messagingSenderId: '807803753641',
    projectId: 'waytoturf-8af8e',
    authDomain: 'waytoturf-8af8e.firebaseapp.com',
    storageBucket: 'waytoturf-8af8e.appspot.com',
    measurementId: 'G-BDXH86QXMK',
  );

}