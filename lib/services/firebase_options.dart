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
    apiKey: 'AIzaSyAdBVLdkQhwfSO8hrbiZIxGkXalvmVAcm8',
    appId: '1:12490320141:web:7efac1bd06b5adb4142844',
    messagingSenderId: '12490320141',
    projectId: 'serenmind-8d180',
    authDomain: 'serenmind-8d180.firebaseapp.com',
    storageBucket: 'serenmind-8d180.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJUeAplGy1x5rze_d2lyvI8WwVo71q0KQ',
    appId: '1:12490320141:android:b7f4e222c67a2fcf142844',
    messagingSenderId: '12490320141',
    projectId: 'serenmind-8d180',
    storageBucket: 'serenmind-8d180.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbFyv0jKCG02WFSU8M1O75J0d-g3gM27k',
    appId: '1:12490320141:ios:b14ab1a5013dffa3142844',
    messagingSenderId: '12490320141',
    projectId: 'serenmind-8d180',
    storageBucket: 'serenmind-8d180.appspot.com',
    iosBundleId: 'com.workshop.serenmind',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbFyv0jKCG02WFSU8M1O75J0d-g3gM27k',
    appId: '1:12490320141:ios:b14ab1a5013dffa3142844',
    messagingSenderId: '12490320141',
    projectId: 'serenmind-8d180',
    storageBucket: 'serenmind-8d180.appspot.com',
    iosBundleId: 'com.workshop.serenmind',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAdBVLdkQhwfSO8hrbiZIxGkXalvmVAcm8',
    appId: '1:12490320141:web:a9bdb3afdd91d61a142844',
    messagingSenderId: '12490320141',
    projectId: 'serenmind-8d180',
    authDomain: 'serenmind-8d180.firebaseapp.com',
    storageBucket: 'serenmind-8d180.appspot.com',
  );
}
