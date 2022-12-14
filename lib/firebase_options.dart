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
    apiKey: 'AIzaSyCDcVc5OBdn6G7Eqn5sj0vZHWaK2KO070k',
    appId: '1:1035077222293:web:fbd72f6e68d3821ffc809c',
    messagingSenderId: '1035077222293',
    projectId: 'nakshekadam2022',
    authDomain: 'nakshekadam2022.firebaseapp.com',
    storageBucket: 'nakshekadam2022.appspot.com',
    measurementId: 'G-SQLXWY80KR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaRZn1cCVpwi-iFyd541YzUSNp6knDR8s',
    appId: '1:1035077222293:android:04f0c66a9d2ab6b3fc809c',
    messagingSenderId: '1035077222293',
    projectId: 'nakshekadam2022',
    storageBucket: 'nakshekadam2022.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwxsAXPMb9XFYMRad5xdlbj-7Hy7MeSIM',
    appId: '1:1035077222293:ios:675c56caaa87a7acfc809c',
    messagingSenderId: '1035077222293',
    projectId: 'nakshekadam2022',
    storageBucket: 'nakshekadam2022.appspot.com',
    androidClientId: '1035077222293-2g20trg8jqktcq79udsefqp1829goont.apps.googleusercontent.com',
    iosClientId: '1035077222293-5lt0a551e60j04ino38023n1ocifksof.apps.googleusercontent.com',
    iosBundleId: 'com.underdogs.nakshekadam',
  );
}
