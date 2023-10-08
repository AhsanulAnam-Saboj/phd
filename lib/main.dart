import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phd/pages/Register.dart';
import 'package:phd/pages/loginpage.dart';
import 'package:phd/pages/Home.dart';
import 'package:phd/pages/Account.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    if (kDebugMode) {
      print(
          '\n \n Printing From App:  Error during Firebase initialization: \n $e \n \n \n');
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false, title: "PHD App", home: Home()));
  } else {
    runApp( MaterialApp(
        debugShowCheckedModeBanner: false, title: "PHD App", home: LoginScreen()));
    /*runApp(MaterialApp(
      initialRoute: '/loginScreen',
      routes: {
        '/home': (context) => Home(),
        '/loginScreen': (context) => LoginScreen(),
        '/profile': (context) => Profile(),
      },
    ));*/
  }
}
