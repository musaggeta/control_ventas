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
    apiKey: 'AIzaSyCn9EGkJwBxc9yIJNiJTCCTbe9MQKX008c',
    appId: '1:508394747264:web:bc5305eb7ef050099f7d65',
    messagingSenderId: '508394747264',
    projectId: 'control-ventas-compras',
    authDomain: 'control-ventas-compras.firebaseapp.com',
    storageBucket: 'control-ventas-compras.firebasestorage.app',
    measurementId: 'G-CM640T1MTR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARPCvKYGsOpXcYlmhrXgbGww7eDdK93Hw',
    appId: '1:508394747264:android:be4a9db8daeb57b89f7d65',
    messagingSenderId: '508394747264',
    projectId: 'control-ventas-compras',
    storageBucket: 'control-ventas-compras.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVII1Eb7B1A8XbEqEzFFccZD40nZ-kml4',
    appId: '1:508394747264:ios:edc64db25e85d7879f7d65',
    messagingSenderId: '508394747264',
    projectId: 'control-ventas-compras',
    storageBucket: 'control-ventas-compras.firebasestorage.app',
    iosBundleId: 'com.example.controlVentas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVII1Eb7B1A8XbEqEzFFccZD40nZ-kml4',
    appId: '1:508394747264:ios:edc64db25e85d7879f7d65',
    messagingSenderId: '508394747264',
    projectId: 'control-ventas-compras',
    storageBucket: 'control-ventas-compras.firebasestorage.app',
    iosBundleId: 'com.example.controlVentas',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCn9EGkJwBxc9yIJNiJTCCTbe9MQKX008c',
    appId: '1:508394747264:web:593446e73e9362159f7d65',
    messagingSenderId: '508394747264',
    projectId: 'control-ventas-compras',
    authDomain: 'control-ventas-compras.firebaseapp.com',
    storageBucket: 'control-ventas-compras.firebasestorage.app',
    measurementId: 'G-B81NN4WQS3',
  );
}
