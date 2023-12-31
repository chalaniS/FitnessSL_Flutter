// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBiv3v2g5rFHwi7C_RU25op6Mc5vCYcQJQ',
    appId: '1:1088694809150:web:d8b1e114dd18bab2a9d76f',
    messagingSenderId: '1088694809150',
    projectId: 'fitnes-411fb',
    authDomain: 'fitnes-411fb.firebaseapp.com',
    databaseURL: 'https://fitnes-411fb-default-rtdb.firebaseio.com',
    storageBucket: 'fitnes-411fb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWBUQh5Vfo8cD3nPEAzyVuBdF0pYAf47Y',
    appId: '1:1088694809150:android:1f261a2445c4dc2ca9d76f',
    messagingSenderId: '1088694809150',
    projectId: 'fitnes-411fb',
    databaseURL: 'https://fitnes-411fb-default-rtdb.firebaseio.com',
    storageBucket: 'fitnes-411fb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWM6q6EEt9j46cB0sF3_CRptF8uXOKw3s',
    appId: '1:1088694809150:ios:55ea2950cefaa10da9d76f',
    messagingSenderId: '1088694809150',
    projectId: 'fitnes-411fb',
    databaseURL: 'https://fitnes-411fb-default-rtdb.firebaseio.com',
    storageBucket: 'fitnes-411fb.appspot.com',
    iosClientId: '1088694809150-sq58p3pu36mdsfbbsdngmfqhq394escr.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitness',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWM6q6EEt9j46cB0sF3_CRptF8uXOKw3s',
    appId: '1:1088694809150:ios:48d64da444f32b46a9d76f',
    messagingSenderId: '1088694809150',
    projectId: 'fitnes-411fb',
    databaseURL: 'https://fitnes-411fb-default-rtdb.firebaseio.com',
    storageBucket: 'fitnes-411fb.appspot.com',
    iosClientId: '1088694809150-86m57l7ch948964a4cj8ckhv7skssccj.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitness.RunnerTests',
  );
}
