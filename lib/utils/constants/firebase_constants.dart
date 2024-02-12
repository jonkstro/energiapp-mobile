import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConstants {
  static final String userCollectionName =
      dotenv.env['userCollectionName'] ?? '';
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
  static final FirebaseOptions firebaseConfig = FirebaseOptions(
    apiKey: dotenv.env['apiKey'] ?? '',
    authDomain: dotenv.env['authDomain'] ?? '',
    projectId: dotenv.env['projectId'] ?? '',
    storageBucket: dotenv.env['storageBucket'] ?? '',
    messagingSenderId: dotenv.env['messagingSenderId'] ?? '',
    appId: dotenv.env['appId'] ?? '',
    measurementId: dotenv.env['measurementId'] ?? '',
  );
}
