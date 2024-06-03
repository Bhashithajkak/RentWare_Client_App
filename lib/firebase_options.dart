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
    apiKey: 'AIzaSyBrZUsQv4FJAfT_jkjtoid-HaC2wjS_gEY',
    appId: '1:63000331937:web:bb9245335a60efc01b52e0',
    messagingSenderId: '63000331937',
    projectId: 'rentware-e468b',
    authDomain: 'rentware-e468b.firebaseapp.com',
    storageBucket: 'rentware-e468b.appspot.com',
    measurementId: 'G-2CZ9RXGFB9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCan3jhZcSvwzoAZBOpAFA-GN7h7l7kJCI',
    appId: '1:63000331937:android:6107a217e8c6814e1b52e0',
    messagingSenderId: '63000331937',
    projectId: 'rentware-e468b',
    storageBucket: 'rentware-e468b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8hoybhInQTb2cNVTQTWf2GpJBtzWRvJk',
    appId: '1:63000331937:ios:fa9fa5f4a5ed549e1b52e0',
    messagingSenderId: '63000331937',
    projectId: 'rentware-e468b',
    storageBucket: 'rentware-e468b.appspot.com',
    iosBundleId: 'com.example.rentware',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8hoybhInQTb2cNVTQTWf2GpJBtzWRvJk',
    appId: '1:63000331937:ios:fa9fa5f4a5ed549e1b52e0',
    messagingSenderId: '63000331937',
    projectId: 'rentware-e468b',
    storageBucket: 'rentware-e468b.appspot.com',
    iosBundleId: 'com.example.rentware',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBrZUsQv4FJAfT_jkjtoid-HaC2wjS_gEY',
    appId: '1:63000331937:web:c1ee02e543ee78991b52e0',
    messagingSenderId: '63000331937',
    projectId: 'rentware-e468b',
    authDomain: 'rentware-e468b.firebaseapp.com',
    storageBucket: 'rentware-e468b.appspot.com',
    measurementId: 'G-3X5GLFEJ62',
  );

}