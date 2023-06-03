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
    apiKey: 'AIzaSyBeJlXoutzXEVGCXt5JnPjfyuhzoNdTe9w',
    appId: '1:888284724155:web:af485dfd27f220c07ba29e',
    messagingSenderId: '888284724155',
    projectId: 'mynotes-flutter-help',
    authDomain: 'mynotes-flutter-help.firebaseapp.com',
    storageBucket: 'mynotes-flutter-help.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC68D38QtR3Ha25mY17x3FLFhv84nPI_qM',
    appId: '1:888284724155:android:30db0cfe72b0662d7ba29e',
    messagingSenderId: '888284724155',
    projectId: 'mynotes-flutter-help',
    storageBucket: 'mynotes-flutter-help.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpjntH1b0jf9DDmf9aZvwRfwLAr6lPvMg',
    appId: '1:888284724155:ios:0a4e8de25c0ff9787ba29e',
    messagingSenderId: '888284724155',
    projectId: 'mynotes-flutter-help',
    storageBucket: 'mynotes-flutter-help.appspot.com',
    iosClientId: '888284724155-96n26703dobvd5r96b5h7tikottostcs.apps.googleusercontent.com',
    iosBundleId: 'com.example.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpjntH1b0jf9DDmf9aZvwRfwLAr6lPvMg',
    appId: '1:888284724155:ios:0980e10f34f73beb7ba29e',
    messagingSenderId: '888284724155',
    projectId: 'mynotes-flutter-help',
    storageBucket: 'mynotes-flutter-help.appspot.com',
    iosClientId: '888284724155-hdb0k4r6f7dg9r88urksh77hp8cd118k.apps.googleusercontent.com',
    iosBundleId: 'com.example.mynotes.RunnerTests',
  );
}
