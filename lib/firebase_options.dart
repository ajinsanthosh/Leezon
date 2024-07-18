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
    apiKey: 'AIzaSyC4RULioFtdC7oroDERgctJGjmRk5CCldU',
    appId: '1:113231739178:web:be8fb22621d33deabcc653',
    messagingSenderId: '113231739178',
    projectId: 'lezon-e3f19',
    authDomain: 'lezon-e3f19.firebaseapp.com',
    storageBucket: 'lezon-e3f19.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7uxk3docBpwlyWxKbLwGtTJ6p-CtLURU',
    appId: '1:113231739178:android:8fba412ada5e812dbcc653',
    messagingSenderId: '113231739178',
    projectId: 'lezon-e3f19',
    storageBucket: 'lezon-e3f19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBPVuUTuJZelaC5HcBqx4rKl0c4aNbk_E',
    appId: '1:113231739178:ios:8ed60bc63bb4ee0abcc653',
    messagingSenderId: '113231739178',
    projectId: 'lezon-e3f19',
    storageBucket: 'lezon-e3f19.appspot.com',
    iosBundleId: 'com.example.leezon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBPVuUTuJZelaC5HcBqx4rKl0c4aNbk_E',
    appId: '1:113231739178:ios:8ed60bc63bb4ee0abcc653',
    messagingSenderId: '113231739178',
    projectId: 'lezon-e3f19',
    storageBucket: 'lezon-e3f19.appspot.com',
    iosBundleId: 'com.example.leezon',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4RULioFtdC7oroDERgctJGjmRk5CCldU',
    appId: '1:113231739178:web:37c7d8465766e2dfbcc653',
    messagingSenderId: '113231739178',
    projectId: 'lezon-e3f19',
    authDomain: 'lezon-e3f19.firebaseapp.com',
    storageBucket: 'lezon-e3f19.appspot.com',
  );

}