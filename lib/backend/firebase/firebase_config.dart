import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBZKRl1rg4RkBh0S_-SHq4-X5JWUC0qI9k",
            authDomain: "seamstress-52376.firebaseapp.com",
            projectId: "seamstress-52376",
            storageBucket: "seamstress-52376.appspot.com",
            messagingSenderId: "1045190183394",
            appId: "1:1045190183394:web:ae07e003d227b246ec51bb"));
  } else {
    await Firebase.initializeApp();
  }
}
