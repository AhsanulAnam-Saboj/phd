import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phd/Auth/loginpage.dart';
import 'package:phd/a%20Main%20Pages/Home.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, title: "PHD App", home: Home()));
  } else {
    runApp(MaterialApp(debugShowCheckedModeBanner: false, title: "PHD App", home: LoginScreen()));
  }
}
