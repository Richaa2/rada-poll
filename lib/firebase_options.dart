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
    apiKey: 'AIzaSyCN845RwXjspoVImwtZMjexTqDKnZW82QY',
    appId: '1:925453507028:web:6530aaac14b8ba7ec49e41',
    messagingSenderId: '925453507028',
    projectId: 'rada-poll',
    authDomain: 'rada-poll.firebaseapp.com',
    storageBucket: 'rada-poll.appspot.com',
    measurementId: 'G-5L3K64R4JK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAV3E8H9z2ohVJeEWKXi0dbA156BXJE1Lw',
    appId: '1:925453507028:android:479c16be93fa9764c49e41',
    messagingSenderId: '925453507028',
    projectId: 'rada-poll',
    storageBucket: 'rada-poll.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBif_rRXcoQSzhVTd4SR7oQMGO_wIEMY3w',
    appId: '1:925453507028:ios:7b7b4b46a4535465c49e41',
    messagingSenderId: '925453507028',
    projectId: 'rada-poll',
    storageBucket: 'rada-poll.appspot.com',
    iosClientId: '925453507028-ju49jtlru7f5qnourmml5if4b4mtcfce.apps.googleusercontent.com',
    iosBundleId: 'com.example.radaPoll',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBif_rRXcoQSzhVTd4SR7oQMGO_wIEMY3w',
    appId: '1:925453507028:ios:7b7b4b46a4535465c49e41',
    messagingSenderId: '925453507028',
    projectId: 'rada-poll',
    storageBucket: 'rada-poll.appspot.com',
    iosClientId: '925453507028-ju49jtlru7f5qnourmml5if4b4mtcfce.apps.googleusercontent.com',
    iosBundleId: 'com.example.radaPoll',
  );
}
