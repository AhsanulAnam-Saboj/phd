import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/loginpage.dart';
import '../a Main Pages/Account.dart';
import '../a Main Pages/Home.dart';
import 'Appointment.dart';

class Medicines extends StatefulWidget {
  const Medicines({super.key});

  @override
  State<Medicines> createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: const Row(children: [
            Text('PHD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
          ]),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                      },
                      color: Colors.white,
                      icon: const Icon(Icons.rss_feed, size: 25)),
                  const Text('Feed', style: TextStyle(color: Colors.white))
                ]),
                Column(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Appointment()));
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.calendar_today, size: 25),
                  ),
                  const Text('Appointment', style: TextStyle(color: Colors.white))
                ]),
                Column(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Medicines()));
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.medical_services, size: 25),
                  ),
                  const Text('Medicines', style: TextStyle(color: Colors.white))
                ]),
                Column(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.account_circle, size: 25),
                  ),
                  const Text('Account', style: TextStyle(color: Colors.white))
                ]),
                Column(
                  children: [
                    PopupMenuButton(
                      icon: const Icon(Icons.menu, color: Colors.white, size: 25),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: const Text('Logout'))
                      ],
                    ),
                    const Text('Menu', style: TextStyle(color: Colors.white))
                  ],
                ),
              ]),
            ),
          ),
        ),
        body: const Center(
          child: Text("....Coming Soon.....",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,

            ),
          ),
        ),
      ),


    );
  }
}
