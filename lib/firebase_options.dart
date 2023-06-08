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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBrBFok_LmZTpe_fsDgPYXVemtx0AQkd-8',
    appId: '1:351542703277:web:ad1fd804ace5bb6d870224',
    messagingSenderId: '351542703277',
    projectId: 'randevu-ae9eb',
    authDomain: 'randevu-ae9eb.firebaseapp.com',
    storageBucket: 'randevu-ae9eb.appspot.com',
    measurementId: 'G-L8WJEKGL4P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmG8V0wtuz1jgkYZ1I2kH79dX4PFVD08Y',
    appId: '1:351542703277:android:94228ead630ac655870224',
    messagingSenderId: '351542703277',
    projectId: 'randevu-ae9eb',
    storageBucket: 'randevu-ae9eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbmBLWCPzYGCd2v2Uffhe_00lXggVekN8',
    appId: '1:351542703277:ios:fa9f7e404b48b177870224',
    messagingSenderId: '351542703277',
    projectId: 'randevu-ae9eb',
    storageBucket: 'randevu-ae9eb.appspot.com',
    iosClientId: '351542703277-osd7qj5u5gs3vcn7fi9ruaorg6vklqh8.apps.googleusercontent.com',
    iosBundleId: 'com.example.randevu',
  );
}
