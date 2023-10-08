import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phd/pages/loginpage.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) => [
      PopupMenuItem(onTap: () {
        FirebaseAuth.instance.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },child: Text('Logout'));
    ],);
  }
}
