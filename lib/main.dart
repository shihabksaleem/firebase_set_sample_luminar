import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_set_2/view/home_screen.dart';
import 'package:firebase_set_2/view/options_screen/options_screen.dart';
import 'package:firebase_set_2/view/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyA_1MGtfrr29wqOsmXUgcTQ7sIC9ct77LI",
        appId: "1:736560471440:android:39e031e5c3034b1767a715",
        messagingSenderId: "",
        projectId: "fir-test-46e78",
        storageBucket: "fir-test-46e78.appspot.com"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return OptionsScreen();
            }
            return RegisterScreeen();
          }),
    );
  }
}
